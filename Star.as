package  {
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	
	public class Star extends Global {
		
		
		public function Star() {
			// constructor code
		}

		public function initStarBtn(TestID: int ):void{
			if(starTest[TestID] == true){
				gotoAndStop(2);
			}else{
				gotoAndStop(1);
			}
			addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				
				gotoAndStop( currentFrame == 1 ? 2 : 1 )
				starTest[TestID] = ! starTest[TestID];
			})
		}
	}
	
}
