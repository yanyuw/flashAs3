package  {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	public class Addition extends Global {
		private var tempOption;
		private var tempAnswer;
		
		public function Addition() {
			additionTestNum = getAdditionTestNum();
			star.initStarBtn(6);

			if(additionTestNum == 3){
				subAdditionTestNum = Math.floor(Math.random()*3);
				questionText.text = additionQ[additionTestNum][subAdditionTestNum];

				tempOption = additionO[additionTestNum][subAdditionTestNum]
				tempAnswer = additionAnswer[additionTestNum][subAdditionTestNum]
			}else if (additionTestNum == 5){
				subAdditionTestNum = Math.floor(Math.random()*2);

				questionText.text = additionQ[additionTestNum][subAdditionTestNum];

				tempOption = additionO[additionTestNum][subAdditionTestNum]
				tempAnswer = additionAnswer[additionTestNum][subAdditionTestNum]
			}else{
				
				questionText.text = additionQ[additionTestNum];
				
				tempOption = additionO[additionTestNum]
				tempAnswer = additionAnswer[additionTestNum]
			}

			optionA.text = tempOption[0];
			optionB.text = tempOption[1];
			optionC.text = tempOption[2];

			optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
				check('A')
			})

			optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				check('B')
			})

			optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				check('C')
			})

			if(additionTestNum == 0){
				optionD.text = tempOption[3];
				optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
					check('D')
				})
			}
			
		}

		private function check(option):void{
			if(option == tempAnswer){
				additionTestResult = true;
			}else{
				additionTestResult = false;
			}
			infoPop.visible = true;

			hoverGlow(infoPop.returnBtn)
			infoPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				infoPop.visible = false;
				returnBtn.visible = true;
				hoverGlow(returnBtn);
				returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
					dispatchEvent(new MyEvent(MyEvent.ADDITION_OVER));
				})
			})

		}

		private function getAdditionTestNum(num): int{
			var newTestArr = periodTestResult.concat([test1Result, test2Result, test3Result])
			var newNum = Math.floor(Math.random()*6)
			while(true){
				if(newTestArr[newNum] || newNum == 4){
					newNum = Math.floor(Math.random()*6)
				}else{
					break;
				}
			}
			return newNum
		}




	}
	
}
