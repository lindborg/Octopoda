package octopoda.display {
	import octopoda.documents.Document;
	import octopoda.modules.Module;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.net.SharedObject;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.Regular;
	
	public class Display extends flash.display.MovieClip {
		public var tween:Tween;
		
		public const TWEEN_DURATION:Number = .5; 
		public const TWEEN_TYPE:String = 'alpha'; 
		
		public function Display() {
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		public function dispatchPseudoEvent(event:Event):void {
			var display:octopoda.display.Display = document.getElementByPseudo(this);
			
			if(display != null) {
				display.dispatchEvent(event);
			}
			else {
				parent.dispatchEvent(event);
			}
		}
		public function dispatchPseudoNameEvent(match:String,event:Event):void {
			var display:octopoda.display.Display = document.getElementByPseudoName(match);
			
			if(display != null) {
				display.dispatchEvent(event);
			}
		}
		public function get relation():MovieClip {
			var element:octopoda.display.Display = document.getElementByName(pseudoName);
			
			if(element != null) {
				return element;
			}
			else {
				return MovieClip(parent);
			}
		}
		public function get document():octopoda.documents.Document {
			return root as octopoda.documents.Document;
		}
		public function get named():Boolean {
			return (name.indexOf('instance') !== 0);
		}
		public function get pseudoName():String {
			var chars:String = 'abcdefghijklmnopqrstuvwxyz0123456789';
			var pseudo:String = '';
			
			for(var i:uint = 0; name.length > i; i++) {
				if(chars.indexOf(name.charAt(i)) !== -1) {
					pseudo += name.charAt(i);
				}
				else {
					break;
				}
			}
			
			return pseudo;
		}
		
		//### EVENTS ###
		
		private function onAddedToStage(event:Event):void {
			setVisibilityByAlpha();
			
			document.registerElement(this);
						
			tween = new Tween(this,TWEEN_TYPE,Regular.easeOut,alpha,(alpha?0:1),TWEEN_DURATION,true);
			tween.stop();
			
			tween.addEventListener(TweenEvent.MOTION_CHANGE,onMotionChange);
		}
		private function onMotionChange(event:TweenEvent):void {
			setVisibilityByAlpha();
		}
		
		//### VISIBILITY ###
		
		public function show():void {
			tween.continueTo(1,TWEEN_DURATION);
			dispatchPseudoNameEvent(pseudoName+'show',new FocusEvent(FocusEvent.FOCUS_IN));
		}
		public function hide():void {
			tween.continueTo(0,TWEEN_DURATION);
			dispatchPseudoNameEvent(pseudoName+'hide',new FocusEvent(FocusEvent.FOCUS_IN));
		}
		protected function setVisibilityByAlpha(setAlpha:Number=-1):Boolean {
			if(setAlpha >= 0) {
				alpha = setAlpha;
			}
			
			if(alpha) {
				visible = true;
				enabled = true;
			}
			else {
				visible = false;
				enabled = false;
			}
			
			return visible;
		}
	}
}