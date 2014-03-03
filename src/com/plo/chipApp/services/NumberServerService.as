package com.plo.chipApp.services
{
	import io.IO;
	import io.Options;
	import io.SocketNamespace;
	
	import org.osflash.signals.Signal;
	import org.robotlegs.mvcs.Actor;
	
	public class NumberServerService extends Actor
	{
		private var _options:Options = new io.Options();
		private var _socket:SocketNamespace;
		private var _connected : Boolean = false;
		
		private var _protocol : String = "http://";
		private var _hostname : String = "localhost";
		
		public var connectSignal : Signal = new Signal();
		public var disconnectSignal : Signal = new Signal();
		public var errorSignal : Signal = new Signal();
		public var closeSignal : Signal = new Signal();
		
		public var receiveNumberSignal : Signal = new Signal();
		
		public function NumberServerService()
		{
			super();
		}
		
		public function init() : void
		{
			_options.port = 3000;
			
		}
		
		public function connect() : void {
			if(!_connected) {
				if(!_socket) {
					_socket = IO.connect(_protocol + _hostname + ':' + _options.port, _options);
					_socket.on(io.Socket.CONNECT, onConnect);
					_socket.on(io.Socket.ERROR, onError);
					_socket.on('server ready', onServerReady);
					_socket.on(io.Socket.DISCONNECT, onDisconnect);		
					_socket.on(io.Socket.CLOSE, onClose);
					
					_socket.on('send number', onNumberReceived);
				} else {
					trace('RECONNECT');
					_socket.reconnect();
				}
				
			}
		}
		
		
		
		public function disconnect() : void {
			if(_connected) {
				_socket.disconnect();
			}
		}
			
		protected function onServerReady(data : Object):void
		{
			trace('ON :: server ready : ' + data);
		}
		
		protected function onConnect(... arguments) : void {
			trace('<<< Connected >>>');
			_socket.emit('client ready', { message: 'client connection ready' });
			_connected = true;
			connectSignal.dispatch('CONNECTED : ' + _protocol + _hostname + ':' + _options.port);
		}
		
		protected function onError(message : String):void
		{
			trace("ERROR");
			errorSignal.dispatch('ERROR : ' + message);
		}
		
		protected function onDisconnect():void
		{
			trace('Server disconnected');
			_connected = false;
			disconnectSignal.dispatch('DISCONNECTED : ' + _protocol + _hostname + ':' + _options.port);
		}
		
		protected function onClose() : void {
			trace('Server close');
			_connected = false;
			connectSignal.dispatch('SERVER CLOSED');
		}
		
		protected function onNumberReceived(number : Object) : void {
			trace('ON :: number received: ' + number.value);
			receiveNumberSignal.dispatch(number.value);
		}
		
		public function get connected() : Boolean {
			return _connected;
		}
	}
}