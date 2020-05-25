package  {
	import flash.utils.*; 
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
    import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class Main extends Global {
		public var a:int = 1;

		//Test1 允客之求
		//标题
		private var curCustomer = 0;
		private var test1Title = [["幸福甜蜜", "卓尔不群"], ["浓郁情思", "叹春自怜"], ["爱恋羞涩", "相思之苦"]]
		// public var startPosX = {};
		// public var startPosY = {};
		public var posX1 = 250;
		public var posX2 = 350;
		public var posY = 235;
		public var selectFlower = [];
		public var test1Result = 0;
		public var test1Answer = [['meihua', 'guihua'], ['juhua', 'haitang'], ['meihua', 'hehua']]
		
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
			

			//debug: 允客之求
			// gotoAndStop("允客之求")
			// initTest1();
            addEventListener(MouseEvent.CLICK, debugFun)
		}

		private function debugFun(e: Event):void{
			//下一场景
			//debug: 提炼室
			gotoAndStop(4);
			initRoom();
			removeEventListener(MouseEvent.CLICK, debugFun)
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
			liqMC.liqCount.text = liquidCount;
		}

		private function initTextArea():void {
            transMC.textArea.buttonMode = true;
            transMC.textArea.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop(currentFrame + 1)
				initRoom();
			});
        }
		
		private function initRoom():void{
			trace(roomMC)
			hoverGlow(roomMC.closeBtn)
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
				initTest3();
			})
			roomMC.paint.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop("人生花谱");
				initTest2();
			})

			//标题
			roomMC.flowerShelf.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
				roomMC.flowerText.visible = true;
            })
            roomMC.flowerShelf.addEventListener(MouseEvent.MOUSE_OUT, function() {
                roomMC.flowerText.visible=false;
            })

			roomMC.ball.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
				roomMC.ballText.visible = true;
            })
            roomMC.ball.addEventListener(MouseEvent.MOUSE_OUT, function() {
                roomMC.ballText.visible=false;
            })
			
			roomMC.paint.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
				roomMC.paintText.visible = true;
            })
            roomMC.paint.addEventListener(MouseEvent.MOUSE_OUT, function() {
                roomMC.paintText.visible=false;
            })
		}

		private function initTest1():void{
			hoverGlow(Test1MC.closeBtn)
			Test1MC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				Test1MC.gotoAndStop(2);
				initTest1Content()
			})
		}
		private function initTest2():void{
			hoverGlow(Test2MC.closeBtn)
			Test2MC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				Test2MC.gotoAndStop(2);
				Test2MC.initTest2Content()
				Test2MC.addEventListener(MyEvent.ROOM_TEST2_OVER, function(e: MyEvent){
					gotoAndStop(4);
					roomMC.gotoAndStop(2);
					initRoomBtn()
					if(test2Result == false){
						liquidCount--;
						liqMC.liqCount.text = liquidCount;
					}
				})
			})
		}
		private function initTest3():void{
			hoverGlow(Test3MC.closeBtn)
			Test3MC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				Test3MC.gotoAndStop(2);
				Test3MC.initTest3Content()
			})
		}

		private function initTest1Content():void{
			//花初始化
			hoverGlow(Test1MC.haitang);
			hoverGlow(Test1MC.hehua);
			hoverGlow(Test1MC.meihua);
			hoverGlow(Test1MC.guihua);
			hoverGlow(Test1MC.juhua);

			//海棠
			Test1MC.haitang.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			Test1MC.haitang.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			Test1MC.haitang.startPosX = Test1MC.haitang.x;
			Test1MC.haitang.startPosY = Test1MC.haitang.y;

			//荷花
			Test1MC.hehua.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			Test1MC.hehua.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			Test1MC.hehua.startPosX = Test1MC.hehua.x;
			Test1MC.hehua.startPosY = Test1MC.hehua.y;

			//梅花
			Test1MC.meihua.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			Test1MC.meihua.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			Test1MC.meihua.startPosX = Test1MC.meihua.x;
			Test1MC.meihua.startPosY = Test1MC.meihua.y;

			//桂花
			Test1MC.guihua.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			Test1MC.guihua.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			Test1MC.guihua.startPosX = Test1MC.guihua.x;
			Test1MC.guihua.startPosY = Test1MC.guihua.y;

			//菊花
			Test1MC.juhua.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			Test1MC.juhua.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			Test1MC.juhua.startPosX = Test1MC.juhua.x;
			Test1MC.juhua.startPosY = Test1MC.juhua.y;
			


			//出售按钮
			hoverGlow(Test1MC.sellBtn)
			Test1MC.sellBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				trace(selectFlower)
				if(selectFlower[0] == test1Answer[curCustomer][0] && selectFlower[1] == test1Answer[curCustomer][1]){
					Test1MC.customerText.text = '谢谢！这就是我想要的花朵！'
					test1Result++;
				}else{
					Test1MC.customerText.text = '错了，这些不是我想要的！'
				}

				var nextCTimerid = setTimeout(function(){
					if(curCustomer == 2){
						gotoAndStop(4);
						roomMC.gotoAndStop(2);
						initRoomBtn()
					}else{
						Test1MC.gotoAndStop(Test1MC.currentFrame+1);
						curCustomer++;
						resetTest1();
					}

					if(nextCTimerid > 0){
						clearTimeout(nextCTimerid);
					}
				}, 1000);
			})
		}

		private function resetTest1():void{
			returnPos(0, '');
			returnPos(1, '');
			selectFlower[0] = undefined;
			selectFlower[1] = undefined;
			Test1MC.title1.text = test1Title[curCustomer][0];
			Test1MC.title2.text = test1Title[curCustomer][1];
		}

		private function startDragEvent(e: MouseEvent):void{
			var obj: MovieClip = e.currentTarget as MovieClip;
			obj.startDrag();
		}

		private function stopDragEvent(e: MouseEvent):void{
			var obj: MovieClip = e.currentTarget as MovieClip;
			obj.stopDrag();
			trace(obj.startPosX, obj.startPosY)
			// trace(obj.name)
			if(obj.hitTestObject(Test1MC.position1)){
				obj.x = posX1;
				obj.y = posY;
				returnPos(0, obj.name);//调整位置
				selectFlower[0] = obj.name;
				trace('select0', selectFlower[0])
				
			} else if(obj.hitTestObject(Test1MC.position2)){
				obj.x = posX2;
				obj.y = posY;
				returnPos(1, obj.name);
				selectFlower[1] = obj.name;
				trace('select1', selectFlower[1])
			}else{
				obj.x = obj.startPosX;
				obj.y = obj.startPosY;
			}
		}

		private function returnPos(idx, name):void{
			if(selectFlower[idx] != undefined && selectFlower[idx].length > 0 && selectFlower[idx] != name){
				Test1MC[selectFlower[idx]].x = Test1MC[selectFlower[idx]].startPosX
				Test1MC[selectFlower[idx]].y = Test1MC[selectFlower[idx]].startPosY
			}
			
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
			})
		}

		private function ruleBtnOnClick(e: Event):void {
			rulesPopUp.visible = !rulesPopUp.visible;
			btnMask.visible = !btnMask.visible;
		}



	}
	
}
