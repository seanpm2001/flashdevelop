package flash.errors
{
	/// A SQLError instance provides detailed information about a failed operation.
	public class SQLError extends Error
	{
		/// [AIR] An array of String values that can be used to construct a locale specific detail error message.
		public function get detailArguments () : Array;

		/// [AIR] A reference number associated with the specific detail message.
		public function get detailID () : int;

		/// [AIR] Details of the current error.
		public function get details () : String;

		/// [AIR] A value indicating the operation that was being attempted when the error occurred.
		public function get operation () : String;

		/// [AIR] Creates a SQLError instance that can be thrown or used with a SQLErrorEvent instance's error property.
		public function SQLError (operation:String = null, details:String = "", message:String = "", id:int = 0, detailID:int = -1, detailArgs:Array = null);

		/// [AIR] Returns the string "Error" by default or the value contained in Error.message property, if defined.
		public function toString () : String;
	}
}
