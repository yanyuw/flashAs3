package  {
	
	import flash.display.MovieClip;
	
	
	public class NoteBtn extends MovieClip {
		public var testID;
		
		public function NoteBtn(txt:String, id:int) {
			// hoverGlow(this)
			this.questionTitle.text = txt;
			this.testID = id;
		}
	}
	
}
