package  {
	import fl.transitions.*;
	import fl.transitions.easing.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
    import flash.utils.*; 
	import flash.text.TextField; 
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	// import flash.text.TextFieldType;

	
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

			//debug跳过用：直接进入测试
			initTestBtn()

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
					basket.gotoAndPlay(1)
				})
			}
			tv.addEventListener(MouseEvent.CLICK, tvPlay)
		}

		//初始化下一个元素
		private function nextElement(poemID:int){
			if(poemID < 4){
				initPoemBtn(this["poem"+period+'_'+(poemID)], poemID)
			}else{
				//进入测试
				initTestBtn()
			}
		}

		//初始化诗词按钮
		private function initPoemBtn(button, poemID:int):void{
			addGlow(button)
			button.addEventListener(MouseEvent.CLICK, function(e: Event){
				button.play();
				poem = poemID;
				intoPoem();
			})
			button.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
				floText(poemID, true)
            })
			button.addEventListener(MouseEvent.MOUSE_OUT, function() {
                floText(poemID, false)
            })
		}

		//初始化测试按钮
		private function initTestBtn():void{
			addGlow(testBtn);
			testBtn.addEventListener(MouseEvent.CLICK, function(e: Event) {
				testPop.visible = true;
				if(period == 1){
					initTest1()
				}else if (period == 2){
					initTest2();
				}else{
					initTest3();
				}
				// this["initTest" + period]();
            })

			//文字hover
			testBtn.addEventListener(MouseEvent.MOUSE_MOVE, function(e: Event) {
				testText.visible = true;
            })
			testBtn.addEventListener(MouseEvent.MOUSE_OUT, function(e: Event) {
                testText.visible = false
            })
		}

		//文字雨
		private function initTest1(){
			var textArr = ["海棠", "少女时期", "叹春自怜", "梅花", "菊花", "桂花", "荷花", "少妇时期", "晚年时期", "幸福甜蜜", "卓尔不群", "浓郁情思", "爱恋羞涩", "相思之苦", "悲惨凄沧", "深忧国衰" ,"平静淡然"];
			// var txtRain = [];
			var myTimer:Timer= new Timer(800, 17); 
			
			//设置字体格式
			var format:TextFormat = new TextFormat();
			format.font = "Microsoft YaHei UI";
            format.size = 20;

			var count = 0;
			shuffle(textArr);//洗牌
			// trace(textArr)

            myTimer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent){
				var txt = new TestRain();
				txt.text = textArr[count++];

				txt.textColor = 0x0000000;            //文字颜色
				txt.multiline = true;                //可输入多行
				txt.wordWrap = true;                 //是否自动换行
				txt.selectable = false;

				txt.setTextFormat(format);		 	 //设置格式

				txt.addEventListener(MyEvent.TEST1_OK, function(e: MyEvent){
					trace("timer end")
					myTimer.stop();
					completeTest1(true)
				})

				testPop.textDown.addChild(txt);
				
				// txtRain.push(txt);
			}); 

			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent){
				trace("onFinish");
				completeTest1(false)
			}); //运行结束后调用

        	myTimer.start();

			//收藏按钮
			initStarBtn(1)		
		}

		private function completeTest1(isRight: Boolean){
			var completeTest1TimerID = setTimeout(function(){
				
				if(isRight){
					initOKPop(1)
				}else{
					initOKPop(2)
				}
				
				if(completeTest1TimerID > 0){
					clearTimeout(completeTest1TimerID);
				}
			}, 1000);
		}

		private function initOKPop(frame):void{
			okPop.gotoAndStop(frame);
			okPop.visible = true;
			okPop.okBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				okPop.visible = false;
				testPop.visible = false;
				gotoAndStop(1)
				updateOutsideGarden(true);
			})
		}

		private function shuffle(array) {
			var index = -1,
				length = array.length,
				lastIndex = length - 1;

			while (++index < length) {
				var rand = index + Math.floor( Math.random() * (lastIndex - index + 1)),
					value = array[rand];
				array[rand] = array[index];
				array[index] = value;
			}

			return array;
		}

		private function initStarBtn(TestID: int):void{
			if(starTest[TestID] == true){
				testPop.star.gotoAndStop(2);
			}else{
				testPop.star.gotoAndStop(1);
			}
			testPop.star.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				testPop.star.gotoAndStop( testPop.star.currentFrame == 1 ? 2 : 1 )
				testPop.star[TestID] = ! testPop.star[TestID];
			})
			
		}

		private function initTest2(){
			testPop.optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
				
			})
		}
		private function initTest3(){

		}

		private function floText(poemID: int, visible: Boolean){
			this["floText"+poemID].visible = visible;
		}

		private function intoPoem():void{
			var intoTimerid = setTimeout(function(){   
				gotoAndStop(5); //四朵花界面
				initBtn();
				learnBG.gotoAndStop(poem+(period-1)*3); //背景
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
				gotoLearn("原文"+period+"_"+poem, 0)
			})
			explainBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoLearn("解诗", 1)
			})
			talkBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoLearn("说诗", 2)
			})
			appreBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				gotoLearn("赏诗", 3)
			})
		}

		private function gotoLearn(frame, tab){
			
			trace('frame', frame)
			gotoAndStop(currentFrame+1)
			learnMC.gotoAndStop(frame)
			learnMC.setVisited(tab)
			learnMC.tabPlay(tab)

			//初始化花朵
			flower.gotoAndStop( (poemFlower[period][poem-1] - 1) * 5 + 1)
			// trace('花朵',(poemFlower[period][poem-1] - 1) * 5 + 1 )
			learnMC.addEventListener(MyEvent.UPDATE_FLOWER, function(e: MyEvent){
				updateFlow();
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
			basket.gotoAndStop(poem*24)
			trace("basket curr", basket.currentFrame);
			if(next){
				flower.visible = true;
				flower.getFlower.gotoAndStop(poemFlower[period][poem-1])
				flower.gotoAndPlay(1);
				poem += 1;
				trace(poem)
				completeLearn = false;
				var nextTimerID = setTimeout(function(){
					basket.play()
					if(nextTimerID > 0){
						clearTimeout(nextTimerID);
					}
				}, 1600);
			}
			nextElement(poem);
			tv.tv.gotoAndStop(period);
			if(next){

			}

		}
		
	}
	
}
