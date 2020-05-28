package  {
	
	import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
	
	
	public class NormalMode extends Global {
		
		
		public function NormalMode() {
			// constructor code
			leftArrow.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop(currentFrame - 1);
			})
			rightArrow.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop(currentFrame + 1);
			})
		}
	}
	
}
