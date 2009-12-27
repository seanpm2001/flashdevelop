package flash.sampler
{
	public function _getInvocationCount (obj:Object, qname:QName, type:uint) : Number;

	public function _setSamplerCallback (f:Function) : void;

	/// Clears the current set of Sample objects.
	public function clearSamples () : void;

	/// Returns the number of times a get function was executed.
	public function getGetterInvocationCount (obj:Object, qname:QName) : Number;

	/// Returns the number of times a method was executed.
	public function getInvocationCount (obj:Object, qname:QName) : Number;

	/// Returns an object containing all members of a specified object, including private members.
	public function getMemberNames (o:Object, instanceNames:Boolean = false) : Object;

	/// Returns the number of samples collected.
	public function getSampleCount () : Number;

	/// Returns an object of memory usage Sample instances from the last sampling session.
	public function getSamples () : Object;

	/// Returns the number of times a set function was executed.
	public function getSetterInvocationCount (obj:Object, qname:QName) : Number;

	/// Returns the size in memory of a specified object when used with the Flash Player 9.0.115.0 or later debugger version.
	public function getSize (o:*) : Number;

	/// Checks to see if a property is defined by a get/set function.
	public function isGetterSetter (obj:Object, qname:QName) : Boolean;

	/// Stops the sampling process momentarily.
	public function pauseSampling () : void;

	public function sampleInternalAllocs (b:Boolean) : void;

	public function setSamplerCallback (f:Function) : void;

	/// Begins the process of collecting memory usage Sample objects.
	public function startSampling () : void;

	/// Ends the process of collecting memory usage Sample objects and frees resources dedicated to the sampling process.
	public function stopSampling () : void;

}