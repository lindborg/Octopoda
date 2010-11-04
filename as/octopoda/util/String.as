// ActionScript Document

package octopoda.util {
	public class String {
		public static function formatArrayToURL(arrayURL:Array,encoding:String='UTF-8'):String {
			var query:Array = [];
			
			for(var index in arrayURL) {
				query.push(index+'='+escape(arrayURL[index]));
			}
			
			return query.join('&');
		}
		public static function formatURLToArray(urlArray:Array,encoding:String='UTF-8'):String {
			var segments:Array = urlArray.split('&');
			var data:Object = {};
			
			return data;
		}
	}
}