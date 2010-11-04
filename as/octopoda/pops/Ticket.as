package octopoda.pops {
	import octopoda.pops.Pop;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Ticket extends Pop {		
		public function Ticket() {
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		private function onAddedToStage(event:Event):void {
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private function onEnterFrame(event:Event):void {
			rotation = Math.max(Math.min(mouseY/5,50),-50);
		}
	}
}