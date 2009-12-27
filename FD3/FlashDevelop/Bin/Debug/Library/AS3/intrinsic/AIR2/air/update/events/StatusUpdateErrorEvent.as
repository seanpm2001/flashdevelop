package air.update.events
{
	import flash.events.ErrorEvent;
	import flash.events.Event;

	/// A StatusUpdateErrorEvent is dispatched when a call to the checkForUpdate() method of an ApplicationUpdater object encounters an error while downloading or parsing the update descriptor file.
	public class StatusUpdateErrorEvent extends ErrorEvent
	{
		/// Provides information in addition to the errorId property.
		public var subErrorID : int;
		/// The StatusUpdateErrorEvent.UPDATE_ERROR constant defines the value of the type property of the event object for a statusUpdateError event.
		public static const UPDATE_ERROR : String;

		/// Creates a copy of the object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// The constructor function.
		public function StatusUpdateErrorEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0, subErrorID:int = 0);

		/// Returns a string that contains all the properties of the object.
		public function toString () : String;
	}
}