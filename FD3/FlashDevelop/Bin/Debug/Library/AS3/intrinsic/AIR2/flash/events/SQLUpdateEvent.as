package flash.events
{
	import flash.events.Event;

	/// A SQLUpdateEvent object is dispatched by a SQLConnection object when a data change occurs on any table associated with the SQLConnection instance.
	public class SQLUpdateEvent extends Event
	{
		/// The SQLUpdateEvent.DELETE constant defines the value of the type property of a SQLConnection delete event.
		public static const DELETE : String = "delete";
		/// The SQLUpdateEvent.INSERT constant defines the value of the type property of a SQLConnection insert event.
		public static const INSERT : String = "insert";
		/// The SQLUpdateEvent.UPDATE constant defines the value of the type property of a SQLConnection update event.
		public static const UPDATE : String = "update";

		/// The unique row identifier of the row that was inserted, deleted, or updated.
		public function get rowID () : Number;

		/// The name of the table whose data change caused the event to be dispatched.
		public function get table () : String;

		/// Creates a copy of the SQLUpdateEvent object and sets the value of each property to match that of the original.
		public function clone () : Event;

		/// Used to create new SQLUpdateEvent object.
		public function SQLUpdateEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, table:String = null, rowID:Number = 0);
	}
}