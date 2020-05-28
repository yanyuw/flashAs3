package  {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	public class NoteContent extends Global {
		var starCount = 0;
		var starBtnArr = [];
		var btnPos = [[40, 50], [220, 50], [400, 50],[580, 50],[40,140],[220,140], [400,140]]
		var btnTitle = ['文字雨', '朋友圈', '超时空对话', '允客之求', '人生花谱', '往事回首', '加试']
		
		public function NoteContent() {
			// constructor code
			this.bookmark1.gotoAndStop(2);
			
			hoverGlow(this.bookmark1);
			hoverGlow(this.bookmark2);

			this.bookmark1.addEventListener(MouseEvent.CLICK, function(e:Event){
				gotoAndStop(1);
				bookmark1.gotoAndStop(2);
				bookmark2.gotoAndStop(1);
				updatePage1();
			})
			this.bookmark2.addEventListener(MouseEvent.CLICK, function(e:Event){
				gotoAndStop(2);
				bookmark1.gotoAndStop(1);
				bookmark2.gotoAndStop(2);
				updatePage2();
			})
		}

		public function updatePage1(){
			starCount = 0;
			starBtnArr = [];
			
			for(var testID in starTest){
				if(starTest[testID]){
					noneText.visible = false;
					trace(starTest[testID])
					var btn = new NoteBtn(btnTitle[testID]);
					btn.x = btnPos[starCount][0];
					btn.y = btnPos[starCount][1];
					starCount++;
					btn.testID = testID
					hoverGlow(btn);
					btn.addEventListener(MouseEvent.CLICK, function(e: Event){
						answerTextArea.htmlText = testContent[btn.testID]
					})
					starBtnArr.push(btn);
					addChild(btn);
				}
			}
			
		}
		
		public function updatePage2(){
			
		}

		public function updateNote(){
			if(currentFrame == 1){
				updatePage1();
			}
		}
	}
	
}
