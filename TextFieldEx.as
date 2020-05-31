
package{
    import flash.text.TextField; 
    import flash.media.Sound;
    import flash.net.URLRequest;

    public class TextFieldEx extends TextField {
        public static var count =  0;
        public static var count2 = 0;
        public static var clickSound = new Sound(new URLRequest("music/clickSound.mp3"))
        public static var wrongSound = new Sound(new URLRequest("music/wrongSound.mp3"))
        public static var rightSound = new Sound(new URLRequest("music/rightSound.mp3"))
        public function TextFieldEx() {
            super()
        }
    }
}
