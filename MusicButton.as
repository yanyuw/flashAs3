package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class MusicButton extends Global {
		public var musicStatus:Boolean = true;

		public function MusicButton() {
			trace("重新加载", musicStatus);
			this.buttonMode = true;
			this.gotoAndStop(1);
			addEventListener(MouseEvent.CLICK, function(e:Event) {
				clickSound.play()
				trace("当前状态", musicStatus);
                gotoAndStop(musicStatus == false ? 1 : 2)
				musicStatus = !musicStatus;
				if(musicStatus == false){
					stopBGM();
				}else{
					resumeBGM();
				}
            })
		}

	}
	
}
