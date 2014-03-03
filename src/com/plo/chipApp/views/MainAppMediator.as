package com.plo.chipApp.views
{

	import com.plo.chipApp.models.vo.Stack;
	import com.plo.chipApp.controls.signals.UpdateStackSignal;
	import com.plo.chipApp.models.MainModel;
	import com.plo.chipApp.models.vo.Chip;
	import com.plo.chipApp.services.NumberServerService;
	
	
	import org.robotlegs.mvcs.Mediator;

	
	public class MainAppMediator extends Mediator
	{
		[Inject]
		public var appModel : MainModel;
		
		[Inject]
		public var service : NumberServerService;
		
		[Inject]
		public var updateStackSignal : UpdateStackSignal;
		
		public function MainAppMediator()
		{
			super();
		}
		
		public function get view():ChipApplication
		{
			return viewComponent as ChipApplication;
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			trace("MAINAppMediator :: onRegister");
			appModel.app = view;
			view.clickConnectSignal.add(onClickConnectSignalHandler);
			view.clickDisconnectSignal.add(onClickDisconnectSignalHandler);
			service.connectSignal.add(onConnectedHandler);
			service.disconnectSignal.add(onDisconnectedHandler);
			service.errorSignal.add(onErrorConnectionHandler);
			service.closeSignal.add(onCloseServerHandler);
			service.receiveNumberSignal.add(onReceiveNumberSignal);
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			view.clickConnectSignal.remove(onClickConnectSignalHandler);
			view.clickDisconnectSignal.remove(onClickDisconnectSignalHandler);
			service.connectSignal.remove(onConnectedHandler);
			service.disconnectSignal.remove(onDisconnectedHandler);
			service.errorSignal.remove(onErrorConnectionHandler);
			service.closeSignal.remove(onCloseServerHandler);
			service.receiveNumberSignal.remove(onReceiveNumberSignal);
		}		
		
		private function onClickConnectSignalHandler():void
		{
			service.connect();
		}
		
		private function onClickDisconnectSignalHandler():void
		{
			service.disconnect();
		}

		private function onReceiveNumberSignal(value : int):void
		{
			view.historyDataprovider.addItem({date : new Date().toTimeString(), value : value});
			view.historyDatagrid.validateNow();
			view.historyDatagrid.setSelectedIndex(view.historyDatagrid.dataProvider.length - 1);
			view.historyDatagrid.ensureCellIsVisible(view.historyDatagrid.selectedIndex);
			
			var stacks : Array = new Array();
			var rest : int = value;
			for(var i : int = view.stacksValues.length - 1; i > 0; i--) {
				var chipValue : int = (view.stacksValues.getItemAt(i) as Stack).chipValue;
				stacks.unshift(int(rest / chipValue));
				updateStackSignal.dispatch(chipValue, int(rest / chipValue));
				rest = value % chipValue;
			}
			chipValue = (view.stacksValues.getItemAt(0) as Stack).chipValue;
			stacks.unshift(rest);
			updateStackSignal.dispatch(chipValue, rest);
			
			trace('--------- ' + stacks + ' ----------');
			
		}
		
		private function onConnectedHandler(message : String) : void {
			view.log(message);
			view.connected = service.connected;
		}
		private function onDisconnectedHandler(message : String) : void {
			view.log(message);
			view.connected = service.connected;
		}
		private function onErrorConnectionHandler(message : String) : void {
			view.log(message);
			view.connected = service.connected;
		}
		private function onCloseServerHandler(message : String) : void {
			view.log(message);
			view.connected = service.connected;			
		}
	}
}