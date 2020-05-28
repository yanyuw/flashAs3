package  {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	public class Addition extends Global {
		private var tempOption;
		private var tempAnswer;
		
		public function Addition() {
			additionTestNum = getAdditionTestNum();
			this.star.initStarBtn(6);

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

			tfHover(this.optionA)
			tfHover(this.optionB)
			tfHover(this.optionC)

			this.optionA.text = tempOption[0];
			this.optionB.text = tempOption[1];
			this.optionC.text = tempOption[2];

			this.optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
				check('A')
			})

			this.optionB.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				check('B')
			})

			this.optionC.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				check('C')
			})

			if(additionTestNum == 0){
				tfHover(optionD)
				this.optionD.text = tempOption[3];
				this.optionD.addEventListener(MouseEvent.CLICK, function(e: Event){
					check('D')
				})
			}
			
		}

		private function check(option):void{
			infoPop.visible = true;
			if(option == tempAnswer){
				additionTestResult = true;
				infoPop.gotoAndStop(1)
			}else{
				additionTestResult = false;
				infoPop.gotoAndStop(2)
			}

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

		private function getAdditionTestNum(): int{
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
