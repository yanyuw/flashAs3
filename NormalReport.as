package  {
	
	import flash.display.MovieClip;
	import fl.containers.ScrollPane; 
	import fl.controls.UIScrollBar;
	
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	
	public class NormalReport extends Global {
		public var aSp = new ScrollPane();
		var questionText 
		var tempOption 
		var tempAnswer 
		var normalTestArr 
		var subNumArr
		
		public function NormalReport() {

		}

		public function init(normalTestResult, subArr){
			normalTestArr = normalTestResult
			subNumArr = subArr
			initTestBtn(this.btn1, 0, normalTestResult[0]);
			initTestBtn(this.btn2, 1, normalTestResult[1]);
			initTestBtn(this.btn3, 2, normalTestResult[2]);
			initTestBtn(this.btn4, 3, normalTestResult[3]);
			initTestBtn(this.btn5, 4, normalTestResult[4]);
			initTestBtn(this.btn6, 5, normalTestResult[5]);
			


			aSp.source = answerTextArea; 
			aSp.setSize(850, 200); 
			aSp.move(55, 335); 

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
				if(additionTestNum == 3){
					questionText = additionQ[testID][subNumArr[3]];
					tempOption = additionO[testID][subNumArr[3]]
					tempAnswer = additionAnswer[testID][subNumArr[3]]
				}else if (additionTestNum == 5){

					questionText = additionQ[testID][subNumArr[5]];
					tempOption = additionO[testID][subNumArr[5]]
					tempAnswer = additionAnswer[testID][subNumArr[5]]
				}else{
					
					questionText = additionQ[testID];
					tempOption = additionO[testID]
					tempAnswer = additionAnswer[testID]
				}
				var text = questionText + '\n' + tempOption.join('\n') + '\n【答案】' + tempAnswer
				answerTextArea.htmlText = text;
				aSp.update();
			})
		}
	}
	
}
