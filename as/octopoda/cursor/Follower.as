package octopoda.cursor {
	import octopoda.display.Display;
	import flash.events.Event;
	
	public class Follower extends octopoda.display.Display {
		static const SPEED:int = 30;
		static const KEEP_AWAY:int = 70;
		
		public function Follower() {
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		private function onAddedToStage(event:Event):void {
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			if(parent) {
				var moveX:Number = parent.mouseX+KEEP_AWAY;
				var moveY:Number = parent.mouseY+KEEP_AWAY;
				
				var offsetX:Number = (moveX-x)/SPEED;
				var offsetY:Number = (moveY-y)/SPEED;
				
				x += offsetX;
				y += offsetY;
				
				scaleX = (offsetX >= 0)?-1:1;
			}
		}
	}
}