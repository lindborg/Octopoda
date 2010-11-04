package octopoda.buttons {
	import octopoda.display.Display;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	public class Button extends octopoda.display.Display {
		protected var direction:int = 0;
		protected var eventType:String = '';
		
		public function Button() {
			buttonMode = true;
			useHandCursor = true;
			
			stop();
			
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		private function onAddedToStage(event:Event):void {
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			addEventListener(MouseEvent.CLICK,onClick);
			addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			addEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
		private function onEnterFrame(event:Event):void {
			if(direction) {
				if(direction > 0) {
					nextFrame();
				}
				else {
					prevFrame();
				}
			}
		}
		private function onClick(event:MouseEvent):void {
			if(eventType.length) {
				relation.dispatchEvent(new Event(eventType,true));
			}
		}
		private function onRollOver(event:MouseEvent):void {
			direction = 1;
			relation.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_IN));
		}
		private function onRollOut(event:MouseEvent):void {
			direction = -1;
			relation.dispatchEvent(new FocusEvent(FocusEvent.FOCUS_OUT));
		}
	}
}