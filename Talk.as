package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	public class Talk extends Global {
		private var inputStatus = false;
		
		public function Talk() {
			// constructor code
			init()
		}

		private function init():void{
			stop();
			input.stop()
			input.addEventListener(MouseEvent.CLICK, function(e:Event){
				if(inputStatus == true){
					input.gotoAndStop(1)
					inputStatus = false;
				}else{
					input.gotoAndStop(1+poem+(period-1)*3)
					inputStatus = true;
				}
			})
		}
	}
	
}
