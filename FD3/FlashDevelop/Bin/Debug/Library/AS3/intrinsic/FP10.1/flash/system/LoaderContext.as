package flash.system
{
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;

	/// The LoaderContext class provides options for loading SWF files and other media by using the Loader class.
	public class LoaderContext extends Object
	{
		/// Specifies whether you can use the loadBytes() method of a Loader object to load content with executable code, such as a SWF file.
		public var allowLoadBytesCodeExecution : Boolean;
		/// Specifies the application domain to use for the Loader.load() or Loader.loadBytes() method.
		public var applicationDomain : ApplicationDomain;
		/// Specifies whether the application should attempt to download a URL policy file from the loaded object's server before beginning to load the object itself.
		public var checkPolicyFile : Boolean;
		/// Specifies the security domain to use for a Loader.load() operation.
		public var securityDomain : SecurityDomain;

		/// Creates a new LoaderContext object, with the specified settings.
		public function LoaderContext (checkPolicyFile:Boolean = false, applicationDomain:ApplicationDomain = null, securityDomain:SecurityDomain = null);
	}
}