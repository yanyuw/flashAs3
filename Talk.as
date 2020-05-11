package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.events.Event;
	import fl.containers.ScrollPane; 
	import fl.controls.ScrollPolicy; 

	public class Talk extends Global {
		private var inputStatus = false;
		private var questionText = '';
		// private var talkContent:TalkContent = new TalkContent(); 
		public var aSp = new ScrollPane();

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
			input.question1.addEventListener(MouseEvent.CLICK, function(e:Event){
				questionText = input.question1.text;
				getAnswer(1)
			})
			// if(input.contains(input.question2)){

			// }
		}

		private function getAnswer(questionID):void{
			closeInput();

			talkContent.setContent(questionText, questionID, aSp);
		}
	}
	
}
