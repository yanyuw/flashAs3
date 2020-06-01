package {
	import flash.text.TextField; 
	import flash.events.MouseEvent;
	import flash.events.Event;
    import flash.utils.*;
    import flash.utils.*;
    import flash.media.Sound;
    import flash.net.URLRequest;

    public class TestRain extends TextFieldEx {
        
        var randomX;
        var randomY;
        var speedY;
        var moveSpeed = 10;
        private var intervalId:uint; 
        private var isClick = false;
        private var _cos;
        private var _sin;
        private var dx = 260;
        private var dy = 310;
        private var d = 120;
        private var isCorrect = false;

        public function TestRain() {
            super()

            randomX = 100 + Math.random()*600;
            randomY = Math.random()*10;
            speedY = Math.random() * 3 + 2;;
            this.x = randomX;
            this.y = randomY;
            this.height = 30;

            // trace("cos, sin", _cos, _sin )


            this.addEventListener(MouseEvent.CLICK, onClick)

            this.addEventListener (Event.ENTER_FRAME, enterFrameHandler);
        }

        private function onClick(e: Event):void{
            clickSound.play()

            if(text == '海棠' || text == '少女时期' || text == '叹春自怜'){
                // isCorrect = true;
                
                //!音效
                rightSound.play()
                moveToPos();
                dx += count * d; 
                // trace("count , dx", count, dx);
                
                count++;
                if(count  == 3){
                    dispatchEvent(new MyEvent(MyEvent.TEST1_OK));
                }
                removeEventListener (Event.ENTER_FRAME, enterFrameHandler);
            }else{
                // isCorrect = false;
                
                wrongSound.play()
                //变换颜色
                removeEventListener (Event.ENTER_FRAME, enterFrameHandler);
                
                var colorRedTimerID = setTimeout(function(){
                    textColor = 0xff3333;
                    var colorGreyTimerID = setTimeout(function(){
                        textColor = 0xcccccc;
                        var colorRedTimerID = setTimeout(function(){
                            textColor = 0xff3333;
                            var endTimerID = setTimeout(function(){
                                visible = false;
                                if(endTimerID > 0){
                                    clearTimeout(endTimerID);
                                }
                            }, 200);
                            if(colorRedTimerID > 0){
                                clearTimeout(colorRedTimerID);
                            }
                        }, 200);
                        if(colorGreyTimerID > 0){
                            clearTimeout(colorGreyTimerID);
                        }
                    }, 200);

                    if(colorRedTimerID > 0){
                        clearTimeout(colorRedTimerID);
                    }
                }, 200);

            }
        }

        private function enterFrameHandler(e: Event):void{
            y += speedY;
            if (y > 280) {
                removeEventListener (Event.ENTER_FRAME, enterFrameHandler);
                // if(isClick == false){
                    this.visible = false;
                // }
            }
        }
        
        private function moveToPos(){
            addEventListener (Event.ENTER_FRAME, moveRepeat);
        }


        private function moveRepeat(e: Event):void { 
            
            var dis = Math.sqrt((dx- x) * (dx - x) + (dy - y) * (dy - y));
            _cos = Math.abs(dx - x) / dis;
            _sin = Math.abs(dy - y) / dis;

            if( Math.abs(x-dx) <= 5 && Math.abs(y-dy) <= 5) {
                y = dy;
                removeEventListener(Event.ENTER_FRAME, moveRepeat);
                removeEventListener(MouseEvent.CLICK, onClick)
                textColor = 0x7777ff;
            }else if(Math.abs(x-dx) <= 5){
                if(y > dy){
                    y -= _sin * moveSpeed
                }else{
                    y += _sin * moveSpeed
                }
            }else if(Math.abs(y-dy) <= 5){
                if(x > dx){
                    x -= _cos * moveSpeed
                }else{
                    x += _cos * moveSpeed
                }
            }else{
                if(x > dx){
                    x -= _cos * moveSpeed
                }else{
                    x += _cos * moveSpeed
                }
                
                if(y > dy){
                    y -= _sin * moveSpeed
                }else{
                    y += _sin * moveSpeed
                }
            }
        }

    }
}
