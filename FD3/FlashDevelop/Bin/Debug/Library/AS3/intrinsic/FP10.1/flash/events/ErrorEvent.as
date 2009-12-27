package flash.events
{
	import flash.events.Event;

	/// An object dispatches an ErrorEvent object when an error causes a network operation to fail.
	public class ErrorEvent extends TextEvent
	{
		/// Defines the value of the type property of an error event object.
		public static const ERROR : String = "error";

		/// Contains the reference number associated with the specific error.
		public function get errorID () : int;

		/// Creates a copy of the ErrorEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Constructor for ErrorEvent objects.
		public function ErrorEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0);

		/// Returns a string that contains all the properties of the ErrorEvent object.
		public function toString () : String;
	}
}