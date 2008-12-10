﻿package mx.accessibility
{
	import mx.controls.RadioButton;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	/**
	 *  The RadioButtonAccimpl class is the accessibility class for RadioButton. *  This class inherits from the CheckBoxAccImpl. * *  @helpid 3008 *  @tiptext This is the RadioButtonAccImpl Accessibility Class. *  @review
	 */
	public class RadioButtonAccImpl extends CheckBoxAccImpl
	{
		/**
		 *  @private	 *  Static variable triggering the hookAccessibility() method.	 *  This is used for initializing RadioButtonAccImpl class to hook its	 *  createAccessibilityImplementation() method to RadioButton class 	 *  before it gets called from UIComponent.
		 */
		private static var accessibilityHooked : Boolean;

		/**
		 *  @private	 *  Static method for swapping the createAccessibilityImplementation()	 *  method of RadioButton with the RadioButtonAccImpl class.
		 */
		private static function hookAccessibility () : Boolean;
		/**
		 *  @private	 *  Method for creating the Accessibility class.	 *  This method is called from UIComponent.	 *  @review
		 */
		static function createAccessibilityImplementation (component:UIComponent) : void;
		/**
		 *  Method call for enabling accessibility for a component.	 *  This method is required for the compiler to activate	 *  the accessibility classes for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 *  Constructor.	 *	 *  @param master The UIComponent instance that this AccImpl instance	 *  is making accessible.
		 */
		public function RadioButtonAccImpl (master:UIComponent);
	}
}
