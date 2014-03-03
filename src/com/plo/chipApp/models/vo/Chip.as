package com.plo.chipApp.models.vo
{
	public class Chip extends Object
	{
		public static const C1 : int = 1;
		public static const C5 : int = 5;
		public static const C10 : int = 10;
		public static const C50 : int = 50;
		public static const C100 : int = 100;
		public static const C500 : int = 500;
		public static const C1K : int = 1000;
		public static const C5K : int = 5000;
		public static const C10K : int = 10000;
		
		public var value : int = 1;
		
		public var color : uint = 0;
		
		public function Chip()
		{
			super();
		}
	}
}