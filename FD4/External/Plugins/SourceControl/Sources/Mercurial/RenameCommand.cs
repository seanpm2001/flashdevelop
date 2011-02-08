﻿using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.Utilities;
using System.IO;
using PluginCore.Managers;

namespace SourceControl.Sources.Mercurial
{
    class RenameCommand : BaseCommand
    {
        public RenameCommand(string path, string newName)
        {
            // directly rename empty dirs
            if (Directory.Exists(path) && Directory.GetFiles(path).Length == 0)
            {
                string newPath = Path.Combine(Path.GetDirectoryName(path), newName);
                if (Directory.Exists(newPath)) return;
                try { Directory.Move(path, newPath); }
                catch (Exception ex) { ErrorManager.ShowInfo(ex.Message); }
                return;
            }

            string args = String.Format("mv \"{0}\" \"{1}\"", Path.GetFileName(path), newName);

            Run(args, Path.GetDirectoryName(path));
        }
    }
}
