package octopoda.modules {
	import octopoda.display.Display;
	import octopoda.documents.Document;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import fl.transitions.TweenEvent;
	
	public class Module extends octopoda.display.Display {
		public var currentFocusInLabel:String;
		public var currentFocusOutLabel:String;
		
		private var gotoAndStopState:String = '';
		private var isStateChanging:Boolean = false;
		
		public function Module() {
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			if(currentLabels.length > 0) {
				if(currentLabels[0].frame == 1) {
					dispatchLabelEvent('Start');
					dispatchLabelEvent('Finish');
					stop();
				}
			}
		}
		public function dispatchLabelEvent(suffix:String=null):void {
			suffix = suffix?suffix:((alpha === 1)?'Finish':'Start');
			dispatchEvent(new Event(currentLabel+'Label'+suffix,true));
		}
		
		//### EVENTS ###
		
		private function onAddedToStage(event:Event):void {
			addEventListener('play',onPlay);
			addEventListener('stop',onStop);
			addEventListener('next',onNext);
			addEventListener('previous',onPrevious);
			addEventListener('show',onShow);
			addEventListener('hide',onHide);
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			tween.addEventListener(TweenEvent.MOTION_FINISH,onMotionFinish);
			
			if(alpha) {
				setVisibilityByAlpha(0);
				show();
			}
		}
		private function onPlay(event:Event):void {
			event.stopImmediatePropagation();
			play();
		}
		private function onStop(event:Event):void {
			event.stopImmediatePropagation();
			stop();
		}
		private function onNext(event:Event):void {
			event.stopImmediatePropagation();
			
			if(currentFrame == totalFrames) {
				gotoAndStop(1);
			}
			else {
				nextFrame();
			}
		}
		private function onPrevious(event:Event):void {
			event.stopImmediatePropagation();
			
			if(currentFrame == 1) {
				gotoAndStop(totalFrames);
			}
			else {
				prevFrame();
			}
		}
		private function onShow(event:Event):void {
			//event.stopImmediatePropagation();
			show();
		}
		private function onHide(event:Event):void {
			event.stopImmediatePropagation();
			hide();
		}
		private function onEnterFrame(event:Event):void {
			for(var i:uint = 0; currentLabels.length > i; i++) {
				if(currentLabels[i].frame == currentFrame) {
					if(currentFocusInLabel != currentLabel) {
						currentFocusInLabel = currentLabel;
						dispatchPseudoNameEvent(currentLabels[i].name,new FocusEvent(FocusEvent.FOCUS_IN));
						stop();	
					}
					break;
				}
				else if(currentLabels[i].frame+1 == currentFrame) {
					if(currentFocusOutLabel != currentLabel) {
						currentFocusOutLabel = currentLabel;
						dispatchPseudoNameEvent(currentLabels[i].name,new FocusEvent(FocusEvent.FOCUS_OUT));
					}
					break;
				}
			}
		}
		private function onMotionFinish(event:TweenEvent):void {
			if(isStateChanging) {
				switch(alpha) {
					case 0:
						super.gotoAndStop(gotoAndStopState);
						dispatchLabelEvent();
						show();
						break;
					case 1:
						isStateChanging = false;
						dispatchLabelEvent();
						break;
				}
			}
		}
		
		//OVERRIDE
		
		override public function gotoAndStop(frame:Object,scene:String=null):void {
			if(frame is String) {
				gotoAndStopState = frame.toString();
				
				if(isStateChanging) {
					super.gotoAndStop(gotoAndStopState);
					dispatchLabelEvent();
				}
				else {
					isStateChanging = true;
					hide();
				}
			}
			else {
				super.gotoAndStop(frame,scene);
			}
		}
	}
}