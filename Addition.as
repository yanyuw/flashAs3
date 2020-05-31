package  {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	public class Addition extends Global {
		private var tempOption;
		private var tempAnswer;
		
		public function Addition() {
			
		}
		public function normalModeAddition(additionTestNum){
			// if(additionTestNum > 5){
				closeBtn.visible = true;
				hoverGlow(closeBtn);
				closeBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
					clickSound.play()
					visible = false;
				})
				star.visible = false;

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

				tfHover(optionA, false)
				tfHover(optionB, false)
				tfHover(optionC, false)

				optionA.text = tempOption[0];
				optionB.text = tempOption[1];
				optionC.text = tempOption[2];

				optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
					normalCheck('A', additionTestNum)
					clickSound.play()
				})

				optionB.addEventListener(MouseEvent.CLICK, function(e: Event){
					
					normalCheck('B', additionTestNum)
					clickSound.play()
				})

				optionC.addEventListener(MouseEvent.CLICK, function(e: Event){
					
					normalCheck('C', additionTestNum)
					clickSound.play()
				})

				if(additionTestNum == 0){
					tfHover(optionD)
					optionD.text = tempOption[3];
					optionD.addEventListener(MouseEvent.CLICK, function(e: Event){
						normalCheck('D', additionTestNum)
						clickSound.play()
					})
				}else{
					optionD.visible = false;
				}
			// }
		
		}
		
		public function plotModeAddition(){
			
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

			tfHover(optionA)
			tfHover(optionB)
			tfHover(optionC)

			optionA.text = tempOption[0];
			optionB.text = tempOption[1];
			optionC.text = tempOption[2];

			optionA.addEventListener(MouseEvent.CLICK, function(e: Event){
				check('A')
				clickSound.play()
			})

			optionB.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				check('B')
				clickSound.play()
			})

			optionC.addEventListener(MouseEvent.CLICK, function(e: Event){
				
				check('C')
				clickSound.play()
			})

			if(additionTestNum == 0){
				tfHover(optionD)
				optionD.text = tempOption[3];
				optionD.addEventListener(MouseEvent.CLICK, function(e: Event){
					check('D')
					clickSound.play()
				})
			}
			
		}

		private function normalCheck(option, testNum):void{
			infoPop.visible = true;
			if(option == tempAnswer){
				rightSound.play()
				infoPop.gotoAndStop(1)
			}else{
				wrongSound.play()
				infoPop.gotoAndStop(4)
			}

			hoverGlow(infoPop.returnBtn)
			infoPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				infoPop.visible = false;
				normalModeAddition(testNum+1)
			})

		}

		private function check(option):void{
			infoPop.visible = true;
			if(option == tempAnswer){
				rightSound.play()
				additionTestResult = true;
				infoPop.gotoAndStop(3)
				liquidCount++;
			}else{
				
				wrongSound.play()
				additionTestResult = false;
				infoPop.gotoAndStop(4)
			}

			hoverGlow(infoPop.returnBtn)
			infoPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
				clickSound.play()
				infoPop.visible = false;
				returnBtn.visible = true;
				hoverGlow(returnBtn);
				returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
					clickSound.play()
					if(additionTestResult == false && liquidCount <= 0){
						//直接进入结局
						dispatchEvent(new MyEvent(MyEvent.ADDITION_OVER));
					}else {
						//提炼精油
						dispatchEvent(new MyEvent(MyEvent.ADDITION_OK));
					}
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
