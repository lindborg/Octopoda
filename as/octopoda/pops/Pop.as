package octopoda.pops {
	import octopoda.display.Display;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	import flash.utils.Timer;
	
	public class Pop extends octopoda.display.Display {
		public var dominating:Boolean = true;
		public var pined:Boolean = false;
		public var timeout:int = 0;
		public var views:int = -1;
		
		//public var tweenPulse:Tween;
		public var tweenJiggy:Tween;
		
		public var timer:Timer;
		
		public function Pop() {
			buttonMode = true;
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		//### EVENTS ###
		
		private function onAddedToStage(event:Event):void {
			addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
			addEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
			
			//tweenPulse = new Tween(this,'alpha',Regular.easeInOut,.7,1,.5,true);
			//tweenPulse.addEventListener(TweenEvent.MOTION_FINISH,onMotionFinish);
			
			//tweenJiggy = new Tween(this,'x',Regular.easeInOut,x,x+5,.5,true);
			//tweenJiggy.addEventListener(TweenEvent.MOTION_FINISH,onMotionFinish);
			
			addEventListener(MouseEvent.CLICK,onClick);
			
			timer = new Timer(timeout,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerComplete);
			setTimer();
			
			alpha = 0;
		}
		private function onFocusIn(event:FocusEvent):void {
			event.stopPropagation();
			show();
		}
		private function onFocusOut(event:FocusEvent):void {
			event.stopPropagation();
			hide();
		}
		private function onTimerComplete(event:TimerEvent):void {
			hide();
		}
		private function onMotionFinish(event:TweenEvent):void {
			event.target.yoyo();
		}
		private function onClick(event:MouseEvent):void {
			hide();
		}
		public function dominate():void {
			for(var i:int = 0; parent.numChildren > i; i++) {
				var box:Pop = parent.getChildAt(i) as octopoda.pops.Pop;
				if(box is octopoda.pops.Pop) {
					if(box !== this && !box.pined && box.dominating && box.alpha > 0) {
						box.hide();
					}
				}
			}
		}
		
		//### SHOW/HIDE ###
		
		public override function show():void {
			if(views) {
				super.show();
				
				if(dominating) {
					dominate();
				}
				
				setTimer();
				
				//tweenPulse.start();
				//tweenJiggy.start();
				
				views--;
			}
		}
		public override function hide():void {
			super.hide();
			
			//tweenPulse.stop();
			//tweenJiggy.stop();
			
			timer.stop();
			timer.reset();
		}
		public function setTimer():void {
			if(timeout) {
				timer.reset();
				timer.start();
			}
		}
	}
}