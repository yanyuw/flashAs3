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
			this.startMC.addEventListener(MyEvent.START_OVER, gotoGarden)
			init();
		}

		private function init():void {
			hoverGlow(musicBtn);
			hoverGlow(ruleBtn);
			hoverGlow(basketBtn);
			hoverGlow(noteBtn);

		}

		private function gotoGarden(e: MyEvent):void {
			gotoAndStop(currentFrame+1)

			//按钮
			ruleBtn.addEventListener(MouseEvent.CLICK, ruleBtnOnClick)
			
			//过渡
			gardenMcTransition();
			
			gardenMC.addEventListener(MyEvent.GARDEN_OVER, gotoNext)
		}

		private function gotoNext(e: MyEvent):void {
			gotoAndStop(currentFrame+1)
			
			//对话框
			initTextArea();

			//养护液
			liqMC.liqCount = liquidCount;
		}

		private function initTextArea():void {
            transMC.textArea.buttonMode = true;
            transMC.textArea.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop(currentFrame + 1)
				initRoom();
			});
        }
		
		private function initRoom():void{
			roomMC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				// roomMC.roomRule.visible = false;
				// roomMC.closeBtn.visible = false;
				roomMC.gotoAndStop(2);
				initRoomBtn()
			})
		}

		private function initRoomBtn():void{
			hoverGlow(roomMC.flowerShelf);
			hoverGlow(roomMC.ball);
			hoverGlow(roomMC.paint);
			
			roomMC.flowerShelf.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop("允客之求")
				initTest1();
			})
			roomMC.ball.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop("往事回首");
				initTest2();
			})
			roomMC.paint.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop("人生花谱");
				initTest3();
			})
		}

		private function initTest1():void{
			Test1MC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				Test1MC.gotoAndStop(2);
				initRoomBtn()
			})
		}
		private function initTest2():void{
			Test2MC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				Test2MC.gotoAndStop(2);
			})
		}		
		private function initTest3():void{
			Test3MC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				Test3MC.gotoAndStop(2);
			})
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
