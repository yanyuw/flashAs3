package  {
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
    import flash.utils.*; 
	
	public class Garden extends Global {
		public var transitionIn = Iris;
		public var transitionOut = Zoom;
		public var completeLearn:Boolean = false;
		
		// 花篮移动速度
		private var speed = 5;
		
		public function Garden() {
			super()
			init();

		}
		private function init():void{
			stop();
			hoverGlow(room);
			trace("garden重新加载")
			move();

			//监听点击事件
			footstep1.addEventListener(MyEvent.INTO_PERIOD, function(e: MyEvent){
				intoPeriod(e, 1)
			})
		}

		//图标移动
		private function move():void{
			this.footstep1.move(period);
			this.footstep2.move(period);
			this.footstep3.move(period);
		}

		private function intoPeriod(e: MyEvent, periodID):void{
			gotoAndStop(currentFrame+periodID)
			period=periodID
			initTVBtn();
			trace("当前时期",periodID)
		}

		private function initTVBtn():void{
			
			tv.tv.gotoAndStop(period)
			addGlow(tv)
			tv.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
				tvText.visible = true;
            })
            tv.addEventListener(MouseEvent.MOUSE_OUT, function() {
                tvText.visible=false;
            })

			function tvPlay(e: Event){
				tv.play();
				var removeTimerID = setTimeout(function(){
					hoverGlow(closeTV)
					closeTV.visible = true;
					tv.removeEventListener(MouseEvent.CLICK, tvPlay)
					if(removeTimerID > 0){
						clearTimeout(removeTimerID);
					}
				}, 1000);
				closeTV.addEventListener(MouseEvent.CLICK, function(e: Event){
					tv.gotoAndStop(1);
					closeTV.visible = false;
					removeGlow(tv)
					nextElement(1)
				})
			}
			tv.addEventListener(MouseEvent.CLICK, tvPlay)
		}

		//初始化下一个元素
		private function nextElement(poemID:int){
			basket.gotoAndPlay(poem == 1 ? 1 : (poemID-1)*24)
			initPoemBtn(this["poem"+period+'_'+(poemID)], poemID)
		}

		//初始化下一个元素
		private function initPoemBtn(button, poemID:int):void{
			addGlow(button)
			button.addEventListener(MouseEvent.CLICK, function(e: Event){
				button.play();
				poem = poemID;
				intoPoem();
			})
		}

		private function intoPoem():void{
			var intoTimerid = setTimeout(function(){   
				gotoAndStop(period*4+poem);
				initBtn();
				if(intoTimerid > 0){
					clearTimeout(intoTimerid);
				}
			}, 1000);
		}

		private function initBtn(){
			hoverGlow(learnBtn)
			hoverGlow(explainBtn)
			hoverGlow(talkBtn)
			hoverGlow(appreBtn)
			learnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoLearn(1, 0)//!
			})
			explainBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoLearn(9, 1)//!
			})
			talkBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoLearn(10, 2)//!
			})
			appreBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoLearn(11, 3)//!
			})
		}

		private function gotoLearn(frame, tab){
			gotoAndStop(currentFrame+1)
			learnMC.gotoAndStop(frame)
			learnMC.setVisited(tab)

			//初始化花朵
			flower.gotoAndStop( (poemFlower[period][poem-1] - 1) * 5 + 1)
			learnMC.addEventListener(MyEvent.FLOWER_UPDATE, function(e: MyEvent){
				updateFlow();
				trace('?')
			})
			updateFlow();

			//返回按钮
			hoverGlow(returnBtn)
			returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoAndStop(1+period)
				updateInsideGarden(completeLearn);
			})
			
		}

		public function updateFlow( ){
			flower.gotoAndStop( flower.currentFrame + 1);
			if(flower.currentFrame % 5 == 0){
				completeLearn = true;
			}
		}

		//跳帧时更新
		public function updateOutsideGarden(next: Boolean = false){
			if(next){
				if(period == 1){
					period += 1;
					this.footstep2.addEventListener(MyEvent.INTO_PERIOD, function(e: MyEvent){
						intoPeriod(e, 2)
					})
				}else{
					period += 1;
					this.footstep3.addEventListener(MyEvent.INTO_PERIOD, function(e: MyEvent){
						intoPeriod(e, 3)
					})
				}
				move();
			}else{
				
			}
		}
		
		public function updateInsideGarden(next: Boolean = false){
			if(next){
				poem += 1;
				trace(flower)
				flower.visible = true;
				flower.getFlower.gotoAndStop(poemFlower[period][poem-1])
				flower.gotoAndPlay(1);
				completeLearn = false;
			}else{
				
			}
			tv.tv.gotoAndStop(period);
			nextElement(poem);
		}
		
	// 	private function gardenMcTransition():void {
	//         var myTransitionManager:TransitionManager = new TransitionManager(this);
	//         myTransitionManager.startTransition ({type:this.transitionOut, direction:Transition.OUT, duration:1, easing:Regular.easeOut, shape:Iris.CIRCLE});
	// 	}

	// 	private function moveBasket() {
	// 		basket.addEventListener(Event.ENTER_FRAME, onMove)
	// 	}
		
	// 	private function onMove(e: Event){
	// 		e.target.x += speed
	// 		if(e.target.x >= (150+poem * 200)){
	// 			basket.removeEventListener(Event.ENTER_FRAME ,onMove);//移除enterFrame事件
	// 			var intoTimerid = setTimeout(function(){   
	// 				gotoAndStop(period*4+poem);
	// 				initBtn();
	// 				if(intoTimerid > 0){
	// 					clearTimeout(intoTimerid);
	// 				}
	// 			}, 500);
	// 		}
	// 	}
		
	}
	
}
