package air.net
{
	import flash.net.URLRequest;
	import flash.net.URLStream;

	/// The URLMonitor class monitors availablity of an HTTP- or HTTPS-based service.
	public class URLMonitor extends ServiceMonitor
	{
		/// The numeric status codes representing a successful result.
		public function get acceptableStatusCodes () : Array;
		public function set acceptableStatusCodes (value:Array) : void;

		/// The URLRequest object representing the probe request.
		public function get urlRequest () : URLRequest;

		/// Returns the string representation of the specified object.
		public function toString () : String;

		/// Creates a URLMonitor Object for a specified HTTP- or HTTPS-based service.
		public function URLMonitor (urlRequest:URLRequest, acceptableStatusCodes:Array = null);
	}
}