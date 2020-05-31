package  {
	
	import flash.display.MovieClip;
	
	import flash.text.TextFieldAutoSize;
	import flash.utils.*; 
	import flash.events.MouseEvent;
    import flash.events.Event;
	import flash.text.TextFormat;
	import flash.events.TimerEvent;
	import fl.video.VideoEvent;
	

	public class Test3 extends Global {
		public var test3Count = 0;
		public var test3Answer = []
		private var format:TextFormat;
		private var randomNum = 0;
		
		public function Test3() {
			//设置字体格式
			format= new TextFormat();
			format.font = "Microsoft YaHei UI";
            format.size = 25;
		}

		public function initTest3Content(){
			//收藏
			star.initStarBtn(5)

			video1.addEventListener(VideoEvent.COMPLETE, nextContent);

			
			var text1Arr = ["病起萧萧两鬓华，卧看残月上窗纱。", "暗淡轻黄体性柔，情疏迹远只香留。", "枕上诗书闲处好，门前风景雨来佳。", "昨夜雨疏风骤，浓睡不消残酒。","何须浅碧深红色，自是花中第一流。","泪染轻匀，犹带彤霞晓露痕。", "尽梅花无好意，赢得满衣清泪。", "梅定妒，菊应羞，画栏开处冠中秋。", "骚人可煞无情思，何事当年不见收。", "少妇时期", "晚年时期", "少女时期"];

			// var txtRain = [];
			var myTimer:Timer= new Timer(2600, 12); 
			var count = 0;
			// trace(textArr)

            myTimer.addEventListener(TimerEvent.TIMER, function(event:TimerEvent){
				randomNum = getRandomNum(randomNum);
				trace(randomNum)
				var txt = new Barrage(1, randomNum);
				txt.text = text1Arr[count++];

				txt.textColor = 0x333333;            //文字颜色
				txt.multiline = true;                //可输入多行
				txt.selectable = false;
				txt.wordWrap = false;
				txt.autoSize=TextFieldAutoSize.LEFT;
				txt.setTextFormat(format);		 	 //设置格式

				tfHover(txt)

				txt.addEventListener(MyEvent.ROOM_TEST3_OK, function(e: MyEvent){
					myTimer.stop();
					trace('roomtest3 end')
					test3Count++;
					// nextContent();
				})

				addChild(txt);
				
				// txtRain.push(txt);
			}); 

			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(event:TimerEvent){
				trace("onFinish");
				// nextContent();
			}); //运行结束后调用

        	myTimer.start();
		}

		private function getRandomNum(num): int{
			var newNum = Math.floor(-2 + Math.random()*5)
			while(newNum == num){
				newNum = Math.floor(-2 + Math.random()*5);
			}
			return newNum
		}
		
		private function completeTest3(e: VideoEvent){
			// var completeTest3TimerID = setTimeout(function(){
				gotoAndStop(5);
				if(test3Count == 2){
					//答对
					rightSound.play()
					infoPop.gotoAndStop(1);
					test3Result = true;
					
					hoverGlow(infoPop.returnBtn)
					infoPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
						clickSound.play()
						infoPop.visible = false;
						returnBtn.visible = true;
						hoverGlow(returnBtn);
						returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
							clickSound.play()
							dispatchEvent(new MyEvent(MyEvent.ROOM_TEST3_NEXT));
						})
					})
				}else{
					//答错
					wrongSound.play()
					infoPop.gotoAndStop(2);
					test3Result = false;
					
					hoverGlow(infoPop.returnBtn)
					infoPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
						clickSound.play()
						infoPop.visible = false;
						returnBtn.visible = true;
						hoverGlow(returnBtn);
						returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
							clickSound.play()
							dispatchEvent(new MyEvent(MyEvent.ROOM_TEST3_NEXT));
						})
					})
				}
				
			// 	if(completeTest3TimerID > 0){
			// 		clearTimeout(completeTest3TimerID);
			// 	}
			// }, 2000);
		}

		private function nextContent(event:VideoEvent):void{
			gotoAndStop("清平乐");
			hoverGlow(closeBtn)
			closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				gotoAndStop(currentFrame + 1);
				nowVideo++;
				initContent()
			})
		}

		private function initContent():void{
			
			video2.addEventListener(VideoEvent.COMPLETE, completeTest3);

			var text2Arr = ["年年雪里，常插梅花醉。", "和羞走，倚门回首，却把青梅嗅。", "枕上诗书闲处好，门前风景雨来佳。", "尽梅花无好意，赢得满衣清泪。","今年海角天涯，萧萧两鬓生华。","泪染轻匀，犹带彤霞晓露痕。", "病起萧萧两鬓华，卧看残月上窗纱。", "看取晚年风势，故应难看梅花。", "少妇时期", "晚年时期", "少女时期"];

			
			var myTimer2:Timer= new Timer(2600, 11); 
			

			var count = 0;

            myTimer2.addEventListener(TimerEvent.TIMER, function(event:TimerEvent){
				randomNum = getRandomNum(randomNum);
				var txt = new Barrage(2, randomNum);
				txt.text = text2Arr[count++];

				txt.textColor = 0x333333;            //文字颜色
				txt.multiline = true;                //可输入多行
				txt.selectable = false;
				txt.wordWrap = false;
				txt.autoSize=TextFieldAutoSize.LEFT;
				txt.setTextFormat(format);		 	 //设置格式

				tfHover(txt)

				txt.addEventListener(MyEvent.ROOM_TEST3_OK, function(e: MyEvent){
					myTimer2.stop();
					trace('roomtest3 end')
					test3Count++;
				})

				addChild(txt);
			}); 

			myTimer2.start();
		}

	}
	
}
