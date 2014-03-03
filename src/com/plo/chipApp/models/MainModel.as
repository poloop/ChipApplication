package com.plo.chipApp.models
{
	import flash.display.DisplayObject;
	
	import org.robotlegs.mvcs.Actor;
	
	public class MainModel extends Actor
	{
		public var app : DisplayObject;
		
		private var debug:Boolean = true;
		
		
		public function MainModel()
		{
			super();
		}
		
		public function init() : void
		{
			if(debug)
			{
				
			}
		}
	}
}