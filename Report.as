package  {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
    import flash.events.Event;
	import fl.containers.ScrollPane; 
	import fl.controls.UIScrollBar;
	
	public class Report extends Global {
		public var aSp = new ScrollPane();
		var questionText 
		var tempOption 
		var tempAnswer 

		public function Report() {
			trace(periodTestResult.concat([test1Result, test2Result, test3Result]))
			trace(hasAddition)

			initTestBtn(this.btn1, 0, periodTestResult[0]);
			initTestBtn(this.btn2, 1, periodTestResult[1]);
			initTestBtn(this.btn3, 2, periodTestResult[2]);
			initTestBtn(this.btn4, 3, test1Result);
			initTestBtn(this.btn5, 4, test2Result);
			initTestBtn(this.btn6, 5, test3Result);
			if(hasAddition){
				initAdditionTestBtn();
			}

			this.okBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				dispatchEvent(new MyEvent(MyEvent.REPORT_OVER));
			})
			
			aSp.source = answerTextArea; 
			aSp.setSize(850, 200); 
			aSp.move(55, 335); 
			// aSp.scrollDrag = true;

			addChild(aSp); 
		}
		
		private function initTestBtn(button:MovieClip, testID, testResult):void{
			hoverGlow(button)
			if(testResult){
				button.gotoAndStop(1)
			}else{
				button.gotoAndStop(2)
			}
			button.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				answerTextArea.htmlText = testContent[testID]
				aSp.update();
			})
		}

		private function initAdditionTestBtn():void{
			btn7.visible = true;
			hoverGlow(btn7)
			if(additionTestResult){
				btn7.gotoAndStop(1)
			}else{
				btn7.gotoAndStop(2)
			}
			btn7.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
				if(additionTestNum == 3){
					questionText = additionQ[additionTestNum][subAdditionTestNum];
					tempOption = additionO[additionTestNum][subAdditionTestNum]
					tempAnswer = additionAnswer[additionTestNum][subAdditionTestNum]
				}else if (additionTestNum == 5){

					questionText = additionQ[additionTestNum][subAdditionTestNum];
					tempOption = additionO[additionTestNum][subAdditionTestNum]
					tempAnswer = additionAnswer[additionTestNum][subAdditionTestNum]
				}else{
					
					questionText = additionQ[additionTestNum];
					tempOption = additionO[additionTestNum]
					tempAnswer = additionAnswer[additionTestNum]
				}
				var text = questionText + '\n' + tempOption.join('\n') + '\n【答案】' + tempAnswer
				answerTextArea.htmlText = text;
				aSp.update();
			})
		}

	}
	
}
