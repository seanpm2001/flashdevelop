using System;
using System.Collections.Generic;
using System.IO;

using CodeRefactor.Provider;
using CodeRefactor.FRService;

using ASCompletion.Completion;
using ASCompletion.Context;
using ASCompletion.Model;
using PluginCore;
using PluginCore.Managers;

using ScintillaNet;
using PluginCore.Localization;

namespace CodeRefactor.Commands
{

    /// <summary>
    /// Refactors by renaming the given declaration and all its references.
    /// </summary>
    public class Rename : RefactorCommand<IDictionary<String, List<SearchMatch>>>
    {

        #region Fields and Properties

        private FindAllReferences m_FindAllReferencesCommand;
        private String m_NewName;
        private Boolean m_OutputResults;
        private Boolean m_IgnoreDeclarationSource;

        public String NewName
        {
            get
            {
                return m_NewName;
            }
        }

        #endregion

        #region Constructors

        /// <summary>
        /// A new Rename refactoring command.
        /// Outputs found results.
        /// Uses the current text location as the declaration target.
        /// </summary>
        public Rename()
            : this(true)
        {
        }

        /// <summary>
        /// A new Rename refactoring command.
        /// Uses the current text location as the declaration target.
        /// </summary>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        public Rename(Boolean outputResults)
            : this(RefactoringHelper.GetDefaultRefactorTarget(), outputResults)
        {
        }

        /// <summary>
        /// A new Rename refactoring command.
        /// </summary>
        /// <param name="target">The target declaration to find references to.</param>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        public Rename(ASResult target, Boolean outputResults)
            : this(target, outputResults, null)
        {

        }

        /// <summary>
        /// A new Rename refactoring command.
        /// </summary>
        /// <param name="target">The target declaration to find references to.</param>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        /// <param name="newName">If provided, will not query the user for a new name.</param>
        public Rename(ASResult target, Boolean outputResults, String newName)
            : this(target, outputResults, newName, false)
        {
        }

        /// <summary>
        /// A new Rename refactoring command.
        /// </summary>
        /// <param name="target">The target declaration to find references to.</param>
        /// <param name="outputResults">If true, will send the found results to the trace log and results panel</param>
        /// <param name="newName">If provided, will not query the user for a new name.</param>
        /// <param name="ignoreDeclarationSource">If true, will not rename the original declaration source.  Useful for Encapsulation refactoring.</param>
        public Rename(ASResult target, Boolean outputResults, String newName, Boolean ignoreDeclarationSource)
        {
            // check for invalid refactoring types.  
            // TODO: Ideally, this should report the invalid type to the user or disable the right-click context menu option altogether.
            if (RefactoringHelper.CheckFlag(target.Member.Flags, FlagType.Class) ||
                    RefactoringHelper.CheckFlag(target.Member.Flags, FlagType.Constructor)
                )
            {
                throw new CodeRefactor.Exceptions.TargetNotValidException(TextHelper.GetString("Info.SorryError"));
            }

            this.m_IgnoreDeclarationSource = ignoreDeclarationSource;

            this.m_OutputResults = outputResults;
            
            // gets the new name to refactor to
            this.m_NewName = (newName == null || newName.Trim() == String.Empty) ? GetNewName(target.Member.Name) : newName;

            if (this.m_NewName != null)
            {
                // create a FindAllReferences refactor to get all the changes we need to make
                // we'll also let it output the results, at least until we implement a way of outputting the renamed results later
                this.m_FindAllReferencesCommand = new FindAllReferences(target, false, m_IgnoreDeclarationSource);

                // register a completion listener to the FindAllReferences so we can rename the entries
                this.m_FindAllReferencesCommand.OnRefactorComplete += new EventHandler<RefactorCompleteEventArgs<IDictionary<string, List<SearchMatch>>>>(this.OnFindAllReferencesCompleted);
            }
        }

        #endregion

        #region RefactorCommand Implementation

        /// <summary>
        /// Entry point to execute renaming.
        /// </summary>
        protected override void ExecutionImplementation()
        {
            this.m_FindAllReferencesCommand.Execute();
        }

        /// <summary>
        /// Indicates if the current settings for the refactoring are valid.
        /// </summary>
        public override bool IsValid()
        {
            return this.m_NewName != null && this.m_NewName.Trim() != String.Empty;
        }

        #endregion

        #region Private Helper Methods

        /// <summary>
        /// Renames the given the set of matched references
        /// </summary>
        private void OnFindAllReferencesCompleted(Object sender, RefactorCompleteEventArgs<IDictionary<string, List<SearchMatch>>> eventArgs)
        {
            UserInterfaceManager.FindingReferencesDialogueMain.Show();
            UserInterfaceManager.FindingReferencesDialogueMain.SetTitle(TextHelper.GetString("Info.RenamingReferences"));

            String projectPath = PluginBase.CurrentProject.ProjectPath;
            if (projectPath == null)
            {
                projectPath = String.Empty;
            }
            else
            {
                projectPath = System.IO.Path.GetDirectoryName(projectPath) + "\\";
            }
            int projectPathLength = projectPath.Length;

            foreach (KeyValuePair<String, List<SearchMatch>> entry in eventArgs.Results)
            {
                UserInterfaceManager.FindingReferencesDialogueMain.UpdateStatusMessage(TextHelper.GetString("Info.Updating") + " \"" + (entry.Key.StartsWith(projectPath) ? entry.Key.Substring(projectPathLength) : entry.Key) + "\"");

                // re-open the document and replace all the text
                PluginBase.MainForm.OpenEditableDocument(entry.Key);
                ScintillaControl sci = ASContext.CurSciControl;

                // replace matches in the current file with the new name
                sci.Text = RefactoringHelper.ReplaceMatches(entry.Value, this.m_NewName, sci.Text);

                if (sci.IsModify)
                {
                    this.AssociatedDocumentHelper.MarkDocumentToKeep(sci.FileName);
                }
            }
            
            this.Results = eventArgs.Results;

            if (this.m_OutputResults)
            {
                this.ReportResults();
            }

            UserInterfaceManager.FindingReferencesDialogueMain.Hide();

            this.FireOnRefactorComplete();
        }

        private void ReportResults()
        {
            int newNameLength = this.NewName.Length;
            FlashDevelop.Globals.MainForm.CallCommand("PluginCommand", "ResultsPanel.ClearResults");

            // outputs the lines as they change
            // some funky stuff to make sure it highlights/reports the resultant changes rather than the old data
            // TODO: this works on the assumption that multiple changes on the same line will come from left-to-right; consider updating to work regardless of order
            foreach (KeyValuePair<String, List<SearchMatch>> entry in this.Results)
            {

                // as multiple changes are made to the same line, this stores the cumulative offset 
                Dictionary<int, int> lineOffsets = new Dictionary<int, int>();

                // as multiple changes are made to the same line, this stores the cumulative changes to the line
                Dictionary<int, String> lineChanges = new Dictionary<int, string>();

                // stores a listing of lines to report.  Can store multiple instances of each line as some will have different columns
                Dictionary<int, List<String>> reportableLines = new Dictionary<int, List<string>>();

              
                foreach (SearchMatch match in entry.Value)
                {
                    Int32 column = match.Column;
                    Int32 lineNumber = match.Line;

                    // if we've already modified the line, we use the data from the last change
                    string changedLine = (lineChanges.ContainsKey(lineNumber) ? lineChanges[lineNumber] : match.LineText);
                    int offset = (lineOffsets.ContainsKey(lineNumber) ? lineOffsets[lineNumber] : 0);

                    // offsets our column references to take into account previous changes to the line
                    column = column + offset;

                    // determines what the newly formed line will look like
                    changedLine = changedLine.Substring(0, column) + this.NewName + changedLine.Substring(column + match.Length);
                    
                    // stores the changes in case we have to modify the line again later
                    lineChanges[lineNumber] = changedLine;
                    lineOffsets[lineNumber] = offset + (newNameLength - match.Length);

                    // stores the line entry in our report set
                    if (!reportableLines.ContainsKey(lineNumber))
                    {
                        reportableLines[lineNumber] = new List<string>();
                    }

                    // the data we store matches the TraceManager.Add's formatting.  We insert the {0} at the end so that we can insert the final line state later
                    reportableLines[lineNumber].Add(entry.Key + ":" + match.Line.ToString() + ": characters " + column + "-" + (column + newNameLength) + " : {0}");
                }

                // report all the lines
                foreach (KeyValuePair<int, List<String>> lineSetsToReport in reportableLines)
                {
                    // the final state of the line after all renaming
                    String renamedLine = lineChanges[lineSetsToReport.Key].Trim();

                    foreach (String lineToReport in lineSetsToReport.Value)
                    {
                        // use the String.Format and replace the {0} from above with our final line state
                        TraceManager.Add(String.Format(lineToReport, renamedLine),  (Int32)TraceType.Info);
                    }
                }
            }

            FlashDevelop.Globals.MainForm.CallCommand("PluginCommand", "ResultsPanel.ShowResults");
        }


        /// <summary>
        /// This retrieves the new name from the user
        /// </summary>
        private String GetNewName(String originalName)
        {
            string label = TextHelper.GetString("Label.NewName");
            string title = String.Format(TextHelper.GetString("Title.RenameDialog"), originalName);
            string suggestion = originalName;
            ProjectManager.Helpers.LineEntryDialog askName = new ProjectManager.Helpers.LineEntryDialog(title, label, suggestion);
            System.Windows.Forms.DialogResult choice = askName.ShowDialog();
            if (choice == System.Windows.Forms.DialogResult.OK && askName.Line.Trim().Length > 0 && askName.Line.Trim() != originalName)
            {
                return askName.Line.Trim();
            }

            return null;
        }

        #endregion

    }
}