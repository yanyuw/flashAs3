package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	
	public class BasketContent extends Global {
		
		
		public function BasketContent() {
			// constructor code
			updateContent()
		}

		public function updateContent() {
			gotoAndStop(1);
			for(var i = 1; i <= 9; i++){
				if(i < (period - 1)*3 + poem){
					trace('目前进度',(period - 1)*3 + poem, 'idx', i);
					this['flower'+i].addEventListener(MouseEvent.CLICK, function(e:Event){
						clickSound.play()
						initFlower(e.target, i);
					})
				}else{
					this['flower'+i].gotoAndStop(2);
				}
			}
		}

		private function initArrow():void{
			leftArrow.addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				gotoAndStop(currentFrame - 1);
			})
			rightArrow.addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				gotoAndStop(currentFrame + 1);
			})
		}

		private function initFlower(btn, id:int):void{
			trace(btn.name, id);
			hoverGlow(btn);
			btn.addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				gotoAndStop(id+1);
				initArrow();
			})
		}
	}
	
}
