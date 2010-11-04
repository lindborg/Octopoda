// ActionScript Document

package octopoda.events {
	import flash.events.Event;
	
	public class OctopodaEvent extends flash.events.Event {		
		function OctopodaEvent($type:String,$bubbles:Boolean=true,$cancelable:Boolean=false) {
			super($type,$bubbles,$cancelable);
		}
	}
}