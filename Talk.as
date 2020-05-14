package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.events.Event;
	import fl.containers.ScrollPane; 
	import fl.controls.ScrollPolicy; 
	import flash.text.TextField; 

	public class Talk extends Global {
		private var inputStatus = false;
		private var questionText = '';
		public var aSp = new ScrollPane();

        //必选问题
        private const mustQ = [1, 2, 1, 1, 1, 2, 1, 1, 1];
		//多少问题
		private const countQ = [1, 3, 1, 1, 1, 2, 1, 2, 3];


		public function Talk() {
			// constructor code
			super()
			init()
			
			aSp.source = talkContent; 
			aSp.setSize(580, 230); 
			aSp.move(20, 60); 
			// aSp.scrollDrag = true;

			addChild(aSp); 
		}

		private function init():void{
			stop();
			initInput();
		}

		private function initInput():void {
			// input.stop()
			input.inputBase.addEventListener(MouseEvent.CLICK, function(e:Event){
				if(inputStatus == false){
					input.gotoAndStop(1+poem+(period-1)*3)
					input.inputBase.gotoAndStop(2);
					inputStatus = true;

					//初始化问题点击
					initQuestion();
				}
			})
		}

		private function closeInput():void {
			input.gotoAndStop(1)
			input.inputBase.gotoAndStop(1);
			inputStatus = false;
		}

		private function initQuestion():void{
			var id = poem+(period-1)*3-1;
			var count = countQ[id];
			var must = mustQ[id];
			var i = 1;
			if(alreadyAsk[id] == true){
				enableAnswer(input.question1, 1);
				enableAnswer(input.question2, 2);
				enableAnswer(input.question3, 3);
			}else{
				disableAnswer(count);
				enableAnswer(input["question" + must], must, true, id)
			}
		}

		private function enableAnswer(question, questionID, active = false, id = 0){
			trace("questionID",questionID, id)
			question.textColor = 0x000000;   	
			question.addEventListener(MouseEvent.CLICK, function(e:Event){
				questionText = question.text;
				getAnswer(questionID);
				if(active == true){
					alreadyAsk[id] = true;
				}
			})
		}

		private function disableAnswer(count):void{
			input.question1.textColor = 0xCCCCCC;
			if(count > 1){
				input.question2.textColor = 0xCCCCCC;
				if(count > 2){
					input.question3.textColor = 0xCCCCCC;
				}
			}
		}

		private function getAnswer(questionID):void{
			closeInput();
			trace("questionID", questionID, questionText)
			talkContent.setContent(questionText, questionID, aSp);
		}
	}
	
}
