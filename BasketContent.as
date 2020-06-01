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
			trace(period, poem)
			trace('目前进度',(period - 1)*3 + poem);
			gotoAndStop(1);
			for(var i = 1; i <= 9; i++){
				if(i < (period - 1)*3 + poem){
					if(!this['flower'+i].visited){
						hoverGlow(this['flower'+ i]);
						trace('idx', i);
						this['flower'+i].gotoAndStop(1);
						this['flower'+i].flowerID=i;
						this['flower'+1].visited = true;
						this['flower'+i].addEventListener(MouseEvent.CLICK, initFlower)
					}

				}else{
					this['flower'+i].gotoAndStop(2);
				}
			}
			gotoAndStop(1);
		}

		private function initArrow():void{
			leftArrow.addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				gotoAndStop(currentFrame - 1);
			})
			trace(currentFrame)
			if(currentFrame >= (period - 1)*3 + poem){
				rightArrow.visible = false;
			}else{
				rightArrow.visible = true;
				rightArrow.addEventListener(MouseEvent.CLICK, function(e: Event){
					clickSound.play()
					gotoAndStop(currentFrame + 1);
				})
			}

		}

		private function initFlower(e:Event):void{
			var btn = e.target;
			trace(btn.name,btn.flowerID);
			clickSound.play()
			gotoAndStop(btn.flowerID+1);
			initArrow();
		}
	}
	
}
