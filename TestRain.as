package {
	import flash.text.TextField; 
	import flash.events.MouseEvent;
	import flash.events.Event;

    public class TestRain extends TextField {
        
        var randomX;
        var randomY;
        var speedY;

        public function TestRain() {
            super()
            randomX = Math.random()*800;
            randomY = Math.random()*10;
            speedY = Math.random() * 5 + 2;;
            this.x = randomX;
            this.y = randomY;
            this.addEventListener(MouseEvent.CLICK, function(e: Event){

			})
            this.addEventListener (Event.ENTER_FRAME, enterFrameHandler);
        }

        private function enterFrameHandler(e: Event):void{
            y += speedY;
            if (y > 300) {
                removeEventListener (Event.ENTER_FRAME, enterFrameHandler);
            }
        }

    }
}
