package  {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	public class Report extends Global {
		public var aSp = new ScrollPane();
		var questionText 
		var tempOption 
		var tempAnswer 

		public function Report() {
			initTestBtn(btn1, 0, periodTestResult[0]);
			initTestBtn(btn2, 1, periodTestResult[1]);
			initTestBtn(btn3, 2, periodTestResult[2]);
			initTestBtn(btn4, 3, test1Result);
			initTestBtn(btn5, 4, test2Result);
			initTestBtn(btn6, 5, test3Result);
			if(hasAddition){
				initAdditionTestBtn();
			}

			okBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
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
			if(test3Result){
				button.gotoAndStop(1)
			}else{
				button.gotoAndStop(2)
			}
			button.addEventListener(MouseEvent.CLICK, function(e:Event){
				answerTextArea.htmlText = testContent[testID]
				aSp.update();
			})
		}

		private function initAdditionTestBtn():void{
			hoverGlow(btn7)
			if(additionTestResult){
				button.gotoAndStop(1)
			}else{
				button.gotoAndStop(2)
			}
			btn7.addEventListener(MouseEvent.CLICK, function(e:Event){
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
				var text = questionText + '\n' + tempOption.join('\n') + '【答案】\n' + tempAnswer
				answerTextArea.htmlText = text;
				aSp.update();
			})
		}

	}
	
}
