package octopoda.buttons {
	import octopoda.buttons.Button;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Toogle extends Button {
		public var state:Boolean = false;
		public var toogling:Boolean = true;
		
		public function Toogle() {
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		private function onAddedToStage(event:Event):void {
			addEventListener(MouseEvent.CLICK,onClick);
			setFrameByState();
		}
		private function onClick(event:MouseEvent):void {
			if(toogling) {
				state = state?false:true;
				setFrameByState();
			}
			
			setDisplayByState();
		}
		private function setDisplayByState():void {
			if(state) {
				relation.dispatchEvent(new Event('show',true));
			}
			else {
				relation.dispatchEvent(new Event('hide',true));
			}
		}
		private function setFrameByState():void {
			if(state) {
				gotoAndStop(2);
			}
			else {
				gotoAndStop(1);
			}
		}
	}
}