package com.plo.chipApp
{
	import com.plo.chipApp.views.renderers.StackItemRenderer;
	import com.plo.chipApp.views.StackItemRendererMediator;
	import com.plo.chipApp.controls.signals.UpdateStackSignal;
	import com.plo.chipApp.controls.commands.StartupCommand;
	import com.plo.chipApp.controls.signals.StartupSignal;
	import com.plo.chipApp.models.MainModel;
	import com.plo.chipApp.services.NumberServerService;
	import com.plo.chipApp.views.MainAppMediator;
	
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.SignalContext;
	
	public class ChipAppContext extends SignalContext
	{

		
		override public function startup():void
		{
			
			//map controllers
			signalCommandMap.mapSignalClass(StartupSignal, StartupCommand);
			
			//Signals
			injector.mapSingleton(StartupSignal);
			injector.mapSingleton(UpdateStackSignal);
			
			//map Models
			injector.mapSingleton(MainModel);
			
			//map Services
			injector.mapSingleton(NumberServerService);
			
			//map views
			mediatorMap.mapView(ChipApplication, MainAppMediator);
			mediatorMap.mapView(StackItemRenderer, StackItemRendererMediator);
			
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand);
			super.startup();
		}
	}
}