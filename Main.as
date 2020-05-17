package  {
	import flash.utils.*; 
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
    import flash.events.Event;
	import flash.display.DisplayObject;

	public class Main extends Global {
		public var a:int = 1;
		
		public function Main() {
			// constructor code
			this.stop();
			trace("main",this.startMC.currentFrame)
			this.startMC.addEventListener(MyEvent.START_OVER, gotoNextSence)
			init();
		}

		private function init():void {
			hoverGlow(musicBtn);
			hoverGlow(ruleBtn);
			hoverGlow(basketBtn);
			hoverGlow(noteBtn);

		}

		private function gotoNextSence(e: MyEvent):void {
			gotoAndStop(currentFrame+1)
			// gardenMC
			ruleBtn.addEventListener(MouseEvent.CLICK, ruleBtnOnClick)
			gardenMcTransition();
		}

		private function gardenMcTransition():void {
	        var myTransitionManager:TransitionManager = new TransitionManager(gardenMC);
	        myTransitionManager.startTransition ({type:gardenMC.transitionIn, direction:Transition.IN, duration:1, easing:Regular.easeOut, shape:Iris.CIRCLE});
			gardenMC.blackMask.visible = true;
			var maskTimerid = setTimeout(function(){
				initMask();
				gardenMC.blackMask.visible = false;
				if(maskTimerid > 0){
					clearTimeout(maskTimerid);
				}
			}, 600);
		}
		
		private function initMask():void {
			blackMask.visible = true;
			blackMask.addEventListener(MouseEvent.CLICK, function(e: Event){
				blackMask.gotoAndStop(blackMask.currentFrame+1);
				// if(blackMask.currentFrame == 4){
				// 	this.removeChild(blackMask)
				// }
			})
		}

		private function ruleBtnOnClick(e: Event):void {
			rulesPopUp.visible = !rulesPopUp.visible;
			btnMask.visible = !btnMask.visible;
		}
	}
	
}
