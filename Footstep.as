package  {
	import flash.events.MouseEvent;
    import flash.events.Event;

	public class Footstep extends Global {
		public function Footstep() {
            super()
            hoverGlow(this)
            addEventListener(MouseEvent.CLICK, clickFootstep)   
		}

        private function clickFootstep(e: Event):void{
            var periodID=name.substr(name.length-1,1)  
            // trace("时期",periodID)
            dispatchEvent(new MyEvent(MyEvent.INTO_PERIOD));
            
        }

        public function move(period: int):void{
            var periodID=name.substr(name.length-1,1)  
            if(period != periodID){
                gotoAndStop(1);
            }
        }
		
		
	}
	
}
