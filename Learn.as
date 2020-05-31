package  {
	import flash.events.MouseEvent;
    import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
    import flash.filters.GlowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import fl.containers.ScrollPane; 
	
	
	public class Learn extends Global {
		private var btnStatus = []
		private var btnGlowObj = new GlowFilter(0xFFB6C1, 0.5,20,20);
		public var appreSp = new ScrollPane();
		private var progress = 0;
		private var visited = [];
		private var videoArr = ['鹧鸪天', '点绛唇', '如梦令', '减字木兰花', '醉花阴', '一剪梅', '清平乐', '声声慢', '摊破浣溪沙']


		public function Learn() {
			super()
			init()
		}

		public function setVisited(tab: int){
			visited[tab] = true;
		}
		
		private function init():void{
			// stop();
			trace('init in learn', period, poem)
			title.gotoAndStop(poem+(period-1)*3)

			visited = [false, false, false, false];
			//对选项卡初始化监听事件
			hoverGlow(learnTab, btnGlowObj)
			hoverGlow(explainTab, btnGlowObj)
			hoverGlow(talkTab, btnGlowObj)
			hoverGlow(appreTab, btnGlowObj)

			learnTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				stopVideo()
				gotoAndStop("原文"+period+"_"+poem);
				trace("原文"+period+"_"+poem)
				initLearnBtn();
				initLine();
				tabPlay(0);
				firstTab(0);
				removeTextA()
			})
			explainTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				stopVideo()
				gotoAndStop("解诗");
				tabPlay(1);
				firstTab(1);
				initExplainVideo()
				removeTextA()
			})
			talkTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				stopVideo()
				gotoAndStop("说诗");
				tabPlay(2);
				firstTab(2);
				removeTextA()
			})
			appreTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				stopVideo()
				gotoAndStop("赏诗");
				tabPlay(3);
				firstTab(3);
				initAppreVideo();
				removeTextA()
				
			})
			initLearnBtn();
		}

		public function stopVideo():void{
			if(currentLabel == "解诗"){
				explainVideo.stop()
			}else if(currentLabel == "赏诗"){
				if(appreVideo.playing){
					appreVideo.stop()
				}
			}
		}

		public function initExplainVideo():void{
			var path = '讲解视频/讲解视频-'+ videoArr[poem+(period-1)*3 - 1] +'.mp4'
			explainVideo.source = path;

		}

		public function initAppreVideo():void{
			var path = '欣赏视频/欣赏视频-'+ videoArr[poem+(period-1)*3 - 1] +'.mp4'
			trace(path)
			appreVideo.source = path;
		}

		public function initLine():void{
			tfHover(line1)
			tfHover(line2)
			tfHover(line3)
			if(period != 1 && poem != 3){
				trace("initline4", period, poem)
				tfHover(line4)
				line4.addEventListener(MouseEvent.CLICK, function(e:Event){
					clickSound.play()
					gotoAndStop(currentFrame+7);
					initArrow();
				})
			}
			line1.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				gotoAndStop(currentFrame+4);
				initArrow();
			})
			line2.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				gotoAndStop(currentFrame+5);
				initArrow();
			})
			line3.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				gotoAndStop(currentFrame+6);
				initArrow();
			})


		}

		private function initArrow():void{
			leftArrow.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				gotoAndStop(currentFrame - 1);
			})
			rightArrow.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				gotoAndStop(currentFrame + 1);
			})

		}

		private function initLearnBtn():void{
			//对按钮初始化
			btnStatus=[false, false, false, false]
			
			hoverGlow(originBtn, btnGlowObj)
			hoverGlow(transBtn, btnGlowObj)
			hoverGlow(tipBtn, btnGlowObj)
			hoverGlow(appreBtn, btnGlowObj)
			
			originBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				learnBtn(0)
			})
			transBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				learnBtn(1)
			})
			tipBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				learnBtn(2)
			})
			appreBtn..addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				learnBtn(3)
			})
			
		}

		private function firstTab(index){
			if(visited[index] == false){ // 第一次
				visited[index] = true;
				// trace(visited[index], index, visited)
				progress++;
				dispatchEvent(new MyEvent(MyEvent.UPDATE_FLOWER));
			}
		}

		private function learnBtn( btn: int):void{
			var buttonList = [originBtn, transBtn, tipBtn, appreBtn];
			// var startFrame = "原文"+period+"_"+poem //回到原文
			var startFrame:FrameLabel = currentLabels[poem+(period-1)*3-1]; 
			trace(startFrame.name)
			for(var i = 0; i < 4; i++){
				// trace('状态', i, btnStatus[i])
				// trace('i='+i, 'btn='+btn)
				if(i == btn){
					btnStatus[btn] = true;
					gotoAndStop(startFrame.frame+btn) //
					if(i == 3){
						newTextArea()
					}else{
						removeTextA()
					}
				}else{
					if(btnStatus[btn] == true){
						btnStatus[btn] = false;
					}
				}
			}
			
		}

		public function tabPlay(tab: int):void{
			var tabList = [learnTab, explainTab, talkTab, appreTab];
			for(var i = 0; i < tabList.length; i++){
				if(tab == i){
					tabList[i].gotoAndStop(2);
				}else{
					tabList[i].gotoAndStop(1);
				}
			}
		}


		private function removeTextA(){
			if(contains(appreSp)){
				removeChild(appreSp)	
			}
		}


		private function newTextArea():void{

			appreSp.source = ap; 
			
			if((period == 1 && poem == 1) || (period == 3 && poem == 1)){
				appreSp.setSize(595, 350); 
				appreSp.move(55, 20); 
			}else{
				appreSp.setSize(485, 350); 
				appreSp.move(180, 20); 
			}
			// appreSp.scrollDrag = true;

			addChild(appreSp); 
		}


	}
	
}
