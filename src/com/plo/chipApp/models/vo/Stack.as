package com.plo.chipApp.models.vo {
	/**
	 * @author plong
	 */
	public class Stack extends Object {
		
		public var chipValue : int = Chip.C1;
		
		public var chips : Array;
		
		public var color : uint = 0;
		
		public function Stack() {
		}
		
		public function fill(value : int, color: uint = 0) : void {
			chips = new Array();
			var chip : Chip;
			for(var i : int = 0; i < value; i++) {
				chip = new Chip();
				chip.value = chipValue;
				chip.color = color;
				chips.push(chip);
			}
		}
	}
}
