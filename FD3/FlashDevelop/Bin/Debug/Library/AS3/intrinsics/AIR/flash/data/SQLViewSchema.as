package flash.data
{
	/// A SQLViewSchema instance provides information describing a specific view in a database.
	public class SQLViewSchema extends flash.data.SQLTableSchema
	{
		/// [AIR] Creates a SQLViewSchema instance.
		public function SQLViewSchema(database:String, name:String, sql:String, columns:Array);

	}

}

