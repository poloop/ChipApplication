package com.plo.chipApp.views {
	import com.plo.chipApp.controls.signals.UpdateStackSignal;
	import com.plo.chipApp.views.renderers.StackItemRenderer;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author plong
	 */
	public class StackItemRendererMediator extends Mediator {
		
		[Inject]
		public var updateStackSignal : UpdateStackSignal;
		
		public function StackItemRendererMediator() {
		}
		
		public function get view():StackItemRenderer
		{
			return viewComponent as StackItemRenderer;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			updateStackSignal.add(updateStackSignalHandler);
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			updateStackSignal.remove(updateStackSignalHandler);

		}
		
		protected function updateStackSignalHandler(chipStackValue : int, value : int) : void
		{
			if(view.chipStackValue == chipStackValue) {
				view.updateStack(value);
			}
		}
	}
}
