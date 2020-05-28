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
		public var test1Count = 0;
		public var test1Answer = [['meihua', 'guihua'], ['juhua', 'haitang'], ['meihua', 'hehua']]
		
		public function Main() {
			// constructor code
			this.stop();
			trace("main",this.startMC.currentFrame)
			this.startMC.addEventListener(MyEvent.START_OVER, gotoGarden)
			this.startMC.addEventListener(MyEvent.NORMAL_MODE, intoNormalMode)
			init();
		}

		private function init():void {
			hoverGlow(musicBtn);
			hoverGlow(ruleBtn);
			hoverGlow(basketBtn);
			hoverGlow(noteBtn);
			
            // addEventListener(MouseEvent.CLICK, debugFun)
		}

		private function intoNormalMode():void{
			gotoAndStop("普通模式")
			returnBtn.addEventListener(MouseEvent.CLICK,function(e: Event){
				gotoAndStop(1);
			})
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

			//规则按钮
			ruleBtn.addEventListener(MouseEvent.CLICK, ruleBtnOnClick)
			//花篮按钮
			basketBtn.addEventListener(MouseEvent.CLICK,basketBtnOnClick)
			//笔记按钮
			noteBtn.addEventListener(MouseEvent.CLICK, noteBtnOnClick)

			//过渡
			gardenMcTransition();
			
			gardenMC.addEventListener(MyEvent.GARDEN_OVER, gotoNext)
			gardenMC.addEventListener(MyEvent.UPDATE_LIQUID, function(e: MyEvent){
				liqMC.updateLiqCount();
			})
		}

		private function gotoNext(e: MyEvent):void {
			gotoAndStop(currentFrame+1)
			
			//对话框
			initTextArea();

			//养护液
			liqMC.updateLiqCount()
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
				roomMC.gotoAndStop(2);
				initRoomBtn()
			})
		}

		private function initRoomBtn():void{
			//debug
			// liquidCount++;
			// liqMC.updateLiqCount()
			if(liquidCount <= 0){
				trace('in mc:',liqMC.liqCount.text, 'variable:', liquidCount);
				roomMC.gotoAndStop(3);
				initTipPop(1);
			}else{
				trace('in mc:',liqMC.liqCount.text, 'variable:', liquidCount);
				if(roomTestDone[0] && roomTestDone[1] && roomTestDone[2]){
					roomMC.gotoAndStop(3);
					initTipPop(2);
					
				}else{
					if(roomTestDone[0] == false){
						hoverGlow(roomMC.flowerShelf);
						roomMC.flowerShelf.addEventListener(MouseEvent.CLICK, function(e: Event){
							gotoAndStop("允客之求")
							initTest1();
						})
						roomMC.flowerShelf.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
							roomMC.flowerText.visible = true;
						})
						roomMC.flowerShelf.addEventListener(MouseEvent.MOUSE_OUT, function() {
							roomMC.flowerText.visible=false;
						})

					}
					if(roomTestDone[1] == false){
						hoverGlow(roomMC.paint);
						roomMC.paint.addEventListener(MouseEvent.CLICK, function(e: Event){
							gotoAndStop("人生花谱");
							initTest2();
						})			
						roomMC.paint.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
							roomMC.paintText.visible = true;
						})
						roomMC.paint.addEventListener(MouseEvent.MOUSE_OUT, function() {
							roomMC.paintText.visible=false;
						})
					}
					if(roomTestDone[2] == false){
						hoverGlow(roomMC.ball);
						roomMC.ball.addEventListener(MouseEvent.CLICK, function(e: Event){
							gotoAndStop("往事回首");
							initTest3();
						})
						roomMC.ball.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
							roomMC.ballText.visible = true;
						})
						roomMC.ball.addEventListener(MouseEvent.MOUSE_OUT, function() {
							roomMC.ballText.visible=false;
						})				
					}

				}
			}

		}

		private function initTipPop(frame):void{
			roomMC.tipPop.gotoAndStop(frame);

			hoverGlow(roomMC.tipPop.doBtn)
			hoverGlow(roomMC.tipPop.dontBtn)

			roomMC.tipPop.doBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				trace('做加试')
				hasAddition = true;
				gotoAndStop("加试")
				additionMC.addEventListener(MyEvent.ADDITION_OVER, function(e: MyEvent){
					gotoAndStop("答题报告")
					reportMC.addEventListener(MyEvent.REPORT_OVER, intoEnd)
				})
			})

			roomMC.tipPop.dontBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				trace('不做加试')
				hasAddition = false;
				if(liquidCount > 0){
					//进入好结局
					isGoodEnding = true;
					gotoAndStop("答题报告")
					reportMC.addEventListener(MyEvent.REPORT_OVER, intoEnd)
				}else{
					//养护液没有，不做加试 直接进入坏结局
					isGoodEnding = false;
					gotoAndStop("答题报告")
					reportMC.addEventListener(MyEvent.REPORT_OVER, intoEnd)
				}
			})
		}
		
		private function intoEnd(e: MyEvent){
			gotoAndStop("结局对话");
			initEnding()
		}

		private function initEnding():void{
			if(isGoodEnding){
				ending.textArea.buttonMode = true;
				ending.textArea.addEventListener(MouseEvent.CLICK, function(e: Event){
					if(ending.currentFrame == 1){
						ending.gotoAndStop(ending.currentFrame + 1)
						ending.answer.visible = false;
						initFinalQ()
					}else{
						gotoAndStop(currentFrame + 1)
						initBlackEnd();
					}
				});
			}else{
				ending.gotoAndStop("坏结局")
				ending.textArea.buttonMode = true;
				ending.textArea.addEventListener(MouseEvent.CLICK, function(e: Event){
					gotoAndStop(currentFrame + 1)
					initBlackEnd();
				});
			}
			
		}

		private function initFinalQ():void{
			//关闭按钮
			hoverGlow(ending.closeBtn)
			ending.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				ending.gotoAndStop(ending.currentFrame + 1)
			})
			//输入限制
			ending.input1.maxChars = 1;
			ending.input2.maxChars = 2;
			ending.input3.maxChars = 1;

			//× √
			hoverGlow(ending.okBtn)
			ending.okBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				var count = 0;
				if(ending.input1.text=='桂'){
					count++;
					ending.Feedback1.text = '√'
				}else{
					ending.Feedback1.text = '×'
				}
				if(ending.input2.text==='相思'){
					count++;
					ending.Feedback2.text = '√'
				}else{
					ending.Feedback2.text = '×'
				}
				if(ending.input3.text =='梅'){
					count++;
					ending.Feedback3.text = '√'
				}else{
					ending.Feedback3.text = '×'
				}
				ending.answer.visible = true;
				if(count == 3){
					finalResult = true;
				}
			})
			
		}

		private function initBlackEnd(){
			blackEnd.gotoAndStop(isGoodEnding ? 1: 2);
			blackEnd.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop(currentFrame + 1)
				initResultMC();
			})
			
		}
		
		private function initResultMC():void{
			//resultMC 等级品定报告
			resultMC.liqCount.text = liquidCount;
			var newTestArr = periodTestResult.concat([test1Result, test2Result, test3Result])
			// var resultCount = newTestArr.map()
			// resultMC.ansResult.text = 
			resultMC.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				//回到封面
				gotoAndStop(1);
			})
		}

		private function initBottle():void{
			addGlow(roomMC.bottle);
			roomMC.bottle.addEventListener(MouseEvent.CLICK, function(e: Event){
				roomMC.getBottle.visible = true;
				roomMC.getBottle.play();
				roomMC.getBottle.addEventListener(Event.ENTER_FRAME,overHandler)
				
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

		private function overHandler(e:Event):void{
			var tar = e.target;
			if (tar.currentFrame == 19) {
				tar.addEventListener(MouseEvent.CLICK, function(e: Event){
					tar.play();
				})
			}
			if(tar.currentFrame == tar.totalFrames){
				tar.removeEventListener(Event.ENTER_FRAME,overHandler)
				// gotoAndStop("结局对话");
				gotoAndStop("答题报告")
				
			}
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
					roomTestDone[1] = true;
					gotoAndStop(4);
					
					if(test2Result == false){
						liquidCount--;
						liqMC.updateLiqCount()
					}
					roomMC.gotoAndStop(2);
					initRoomBtn()
				})
			})
		}
		private function initTest3():void{
			hoverGlow(Test3MC.closeBtn)
			Test3MC.closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				Test3MC.gotoAndStop(2);
				Test3MC.initTest3Content()
				Test3MC.addEventListener(MyEvent.ROOM_TEST3_NEXT, function(e: MyEvent){
					roomTestDone[2] = true;
					gotoAndStop(4);
					if(test3Result == false){
						liquidCount--;
						liqMC.updateLiqCount()
					}
					roomMC.gotoAndStop(2);
					initRoomBtn()

				})
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
			
			//收藏
			Test1MC.star.initStarBtn(3)		

			//出售按钮
			hoverGlow(Test1MC.sellBtn)
			Test1MC.sellBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				trace('选择花朵', selectFlower)
				if(selectFlower[0] == test1Answer[curCustomer][0] && selectFlower[1] == test1Answer[curCustomer][1]){
					Test1MC.customerText.text = '谢谢！这就是我想要的花朵！'
					test1Count++;
				}else{
					Test1MC.customerText.text = '错了，这些不是我想要的！'
				}

				var nextCTimerid = setTimeout(function(){
					if(curCustomer == 2){
						Test1MC.gotoAndStop(Test1MC.currentFrame+1);
						Test1MC.infoPop.visible = true;

						if(test1Count == 3){
							test1Result = true;
							Test1MC.infoPop.gotoAndStop(1);
						}else{
							test1Result = false;
							Test1MC.infoPop.gotoAndStop(2);
						}

						hoverGlow(Test1MC.infoPop.returnBtn)
						Test1MC.infoPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: MouseEvent){
							Test1MC.infoPop.visible = false;
							Test1MC.returnBtn.visible = true;
							hoverGlow(Test1MC.returnBtn);
							Test1MC.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
								roomTestDone[0] = true;
								gotoAndStop(4);
								if(test1Result == false){
									liquidCount--;
									liqMC.updateLiqCount()
								}
								roomMC.gotoAndStop(2);
								initRoomBtn()
							})
						})

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
			if(rulesPopUp.visible == false){
				openPopUp(1);
				btnMask.visible = true;
			}else{
				btnMask.visible = false;
				openPopUp(0);
			}
		}

		private function basketBtnOnClick(e: Event):void {
			if(basketPopUp.visible == false){
				openPopUp(2);
				basketPopUp.updateContent();
				btnMask.visible = true;
			}else{
				btnMask.visible = false;
				openPopUp(0);
			}

		}

		private function noteBtnOnClick(e: Event):void {
			if(notePopUp.visible == false){
				openPopUp(3);
				notePopUp.updateNote();
				btnMask.visible = true;
			}else{
				btnMask.visible = false;
				openPopUp(0);
			}
		}

		private function openPopUp(id){
			rulesPopUp.visible = (id == 1);
			basketPopUp.visible = (id == 2);
			notePopUp.visible = (id == 3);
		}

	}
	
}
