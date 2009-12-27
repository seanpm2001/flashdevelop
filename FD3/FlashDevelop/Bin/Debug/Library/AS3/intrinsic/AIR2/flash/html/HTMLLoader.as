package flash.html
{
	import flash.display.Sprite;
	import flash.desktop.JSClipboard;
	import flash.desktop.Clipboard;
	import flash.desktop.NativeDragOptions;
	import flash.display.BitmapData;
	import flash.html.HTMLLoader;
	import flash.display.NativeWindowInitOptions;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.events.KeyboardEvent;
	import flash.html.HTMLHost;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.html.HTMLWindowCreateOptions;
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.html.script.Package;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.html.__HTMLScriptObject;
	import flash.events.FocusEvent;
	import flash.system.ApplicationDomain;
	import flash.display.NativeMenu;
	import flash.events.NativeDragEvent;
	import flash.geom.Point;
	import flash.html.HTMLPopupWindow;
	import flash.html.HTMLHistoryItem;
	import flash.display.Bitmap;
	import flash.events.TextEvent;

	/**
	 * Signals that the HTML DOM has been created in response to a load operation.
	 * @eventType flash.events.Event.HTML_DOM_INITIALIZE
	 */
	[Event(name="htmlDOMInitialize", type="flash.events.Event")] 

	/**
	 * Signals that an uncaught JavaScript exception occurred in the HTMLLoader object.
	 * @eventType flash.events.HTMLUncaughtScriptExceptionEvent.UNCAUGHT_SCRIPT_EXCEPTION
	 */
	[Event(name="uncaughtScriptException", type="flash.events.HTMLUncaughtScriptExceptionEvent")] 

	/**
	 * Signals that the scrollH or scrollV property has been changed by the HTMLLoader object.
	 * @eventType flash.events.Event.SCROLL
	 */
	[Event(name="scroll", type="flash.events.Event")] 

	/**
	 * Signals that one or both of the contentWidth and contentHeight properties of the HTMLLoader object has changed.
	 * @eventType flash.events.Event.HTML_BOUNDS_CHANGE
	 */
	[Event(name="htmlBoundsChange", type="flash.events.Event")] 

	/**
	 * Signals that the location property of the HTMLLoader object has changed.
	 * @eventType flash.events.Event.LOCATION_CHANGE
	 */
	[Event(name="locationChange", type="flash.events.Event")] 

	/**
	 * Signals that the rendering of content in the HTMLLoader object is fully up to date.
	 * @eventType flash.events.Event.HTML_RENDER
	 */
	[Event(name="htmlRender", type="flash.events.Event")] 

	/**
	 * Signals that the last load operation requested by loadString or load method has completed.
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")] 

	/// The HTMLLoader class defines a type of display object that is a container for HTML content.
	public class HTMLLoader extends Sprite
	{
		/// Specifies whether authentication requests should be handled (true) or not (false) for HTTP requests issued by this object.
		public function get authenticate () : Boolean;
		public function set authenticate (value:Boolean) : void;

		/// Specifies whether successful response data should be cached for HTTP requests issued by this object.
		public function get cacheResponse () : Boolean;
		public function set cacheResponse (value:Boolean) : void;

		/// The height, in pixels, of the HTML content.
		public function get contentHeight () : Number;

		/// The width, in pixels, of the HTML content.
		public function get contentWidth () : Number;

		/// Indicates whether any content in the HTMLLoader object is focusable.
		public function get hasFocusableContent () : Boolean;

		/// Specifies the height of the rectangle of the HTML canvas that is being rendered.
		public function get height () : Number;
		public function set height (heightInPixels:Number) : void;

		/// The overall length of the history list, including back and forward entries.
		public function get historyLength () : uint;

		/// The current position in the history list.
		public function get historyPosition () : uint;
		public function set historyPosition (value:uint) : void;

		/// The HTMLHost object used to handle changes to certain user interface elements, such as the window.document.title property of the HTMLLoader object.
		public function get htmlHost () : HTMLHost;
		public function set htmlHost (value:HTMLHost) : void;

		/// Indicates whether the JavaScript load event corresponding to the previous call to the load() or loadString() method has been delivered to the HTML DOM in the HTMLLoader object.
		public function get loaded () : Boolean;

		/// The URL for the content loaded in the HTMLLoader object.
		public function get location () : String;

		/// Specifies whether the HTTP protocol stack should manage cookies for this object.
		public function get manageCookies () : Boolean;
		public function set manageCookies (value:Boolean) : void;

		/// Specifies whether navigation of the root frame of the HTML content (such as when the user clicks a link, when the window.location property is set, or when calling window.open()) results in navigation in the HTMLLoader object (false) or in the default system web browser (true).
		public function get navigateInSystemBrowser () : Boolean;
		public function set navigateInSystemBrowser (value:Boolean) : void;

		public function get numChildren () : int;

		/// Specifies whether the background of the HTMLLoader document is opaque white (true) or not (false).
		public function get paintsDefaultBackground () : Boolean;
		public function set paintsDefaultBackground (newValue:Boolean) : void;

		/// The type of PDF support on the user's system, defined as an integer code value.
		public static function get pdfCapability () : int;

		/// Specifies whether content loaded via the loadString() method is put in the application sandbox (true) or in a non-application sandbox (false).
		public function get placeLoadStringContentInApplicationSandbox () : Boolean;
		public function set placeLoadStringContentInApplicationSandbox (value:Boolean) : void;

		/// The application domain to use for the window.runtime object in JavaScript in the HTML page.
		public function get runtimeApplicationDomain () : ApplicationDomain;
		public function set runtimeApplicationDomain (value:ApplicationDomain) : void;

		/// The horizontal scroll position of the HTML content in the HTMLLoader object.
		public function get scrollH () : Number;
		public function set scrollH (newScrollH:Number) : void;

		/// The vertical scroll position of the HTML content in the HTMLLoader object.
		public function get scrollV () : Number;
		public function set scrollV (newScrollV:Number) : void;

		/// The character encoding used by the HTMLLoader content if an HTML page does not specify a character encoding.
		public function get textEncodingFallback () : String;
		public function set textEncodingFallback (newValue:String) : void;

		/// The character encoding used by the HTMLLoader content, overriding any setting in the HTML page.
		public function get textEncodingOverride () : String;
		public function set textEncodingOverride (newValue:String) : void;

		/// Specifies whether the local cache should be consulted before HTTP requests issued by this object fetch data.
		public function get useCache () : Boolean;
		public function set useCache (value:Boolean) : void;

		/// The user agent string to be used in any upcoming content requests from this HTMLLoader object.
		public function get userAgent () : String;
		public function set userAgent (value:String) : void;

		/// Specifies the width of the rectangle of the HTML canvas that is being rendered.
		public function get width () : Number;
		public function set width (widthInPixels:Number) : void;

		/// The global JavaScript object for the content loaded into the HTML control.
		public function get window () : Object;

		public function addChild (child:DisplayObject) : DisplayObject;

		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;

		public function areInaccessibleObjectsUnderPoint (point:Point) : Boolean;

		/// Cancels any load operation in progress.
		public function cancelLoad () : void;

		public function contains (child:DisplayObject) : Boolean;

		/// Creates a new NativeWindow object that contains an HTMLLoader object.
		public static function createRootWindow (visible:Boolean = true, windowInitOptions:NativeWindowInitOptions = null, scrollBarsVisible:Boolean = true, bounds:Rectangle = null) : HTMLLoader;

		public function getChildAt (index:int) : DisplayObject;

		public function getChildByName (name:String) : DisplayObject;

		public function getChildIndex (child:DisplayObject) : int;

		/// Returns the history entry at the specified position.
		public function getHistoryAt (position:uint) : HTMLHistoryItem;

		public function getObjectsUnderPoint (point:Point) : Array;

		/// Navigates back in the browser history, if possible.
		public function historyBack () : void;

		/// Navigates forward in the browser history, if possible.
		public function historyForward () : void;

		/// Navigates the specified number of steps in the browser history.
		public function historyGo (steps:int) : void;

		/// Creates an HTMLLoader object.
		public function HTMLLoader ();

		/// Loads the HTMLLoader object with data from the site specified by the urlRequestToLoad parameter.
		public function load (urlRequestToLoad:URLRequest) : void;

		/// Loads the HTMLLoader object with the HTML content contained in the HTML string.
		public function loadString (htmlContent:String) : void;

		/// Reloads the page from the current location.
		public function reload () : void;

		public function removeChild (child:DisplayObject) : DisplayObject;

		public function removeChildAt (index:int) : DisplayObject;

		public function setChildIndex (child:DisplayObject, index:int) : void;

		public function swapChildren (child1:DisplayObject, child2:DisplayObject) : void;

		public function swapChildrenAt (index1:int, index2:int) : void;
	}
}