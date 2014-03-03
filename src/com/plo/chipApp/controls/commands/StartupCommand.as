package com.plo.chipApp.controls.commands
{
	

	
	import com.plo.chipApp.models.MainModel;
	import com.plo.chipApp.services.NumberServerService;
	
	import org.robotlegs.mvcs.SignalCommand;
	
	public class StartupCommand extends SignalCommand
	{
		
		[Inject]
		public var appModel : MainModel;
		
		[Inject]
		public var service : NumberServerService;
		
		
		public function StartupCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			trace("STARTUP COMMAND");
			
			appModel.init();
			service.init();
			
		}
		
	}
}