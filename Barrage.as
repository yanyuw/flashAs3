package {
	import flash.text.TextField; 
	import flash.events.MouseEvent;
	import flash.events.Event;
    import flash.utils.*;

    public class Barrage extends TextFieldEx {
        
        var startX = 480;
        var randomY;
        var speedX;
        var moveSpeed = 10;
        private var intervalId:uint; 
        private var isClick = false;
        private var _cos;
        private var _sin;
        private var dx = -450;
        private var dy = 35;
        private var d = 55;
        private var isCorrect = false;
        private var nowVideo;

        public function Barrage(nowVideo, randomNum) {
            super()
            trace(nowVideo, randomNum)
            this.nowVideo = nowVideo;

            randomY = randomNum * 45 - 155;
            speedX = 4 + this.text.length / 4;;

            this.x = startX;
            this.y = randomY;


            if(count2 == 5){
                count2 = 0;
            }

            this.addEventListener(MouseEvent.CLICK, onClick)

            this.addEventListener (Event.ENTER_FRAME, enterFrameHandler);
        }

        private function onClick(e: Event):void{
            
            clickSound.play()

            if(nowVideo == 1){
                if(text == '暗淡轻黄体性柔，情疏迹远只香留。' || text == '少女时期' || text == '何须浅碧深红色，自是花中第一流。' || text == '梅定妒，菊应羞，画栏开处冠中秋。' || text == '骚人可煞无情思，何事当年不见收。' ){
                    rightSelected()
                }else{
                   wrongSelected()
                }
            }else{
                if(text == '年年雪里，常插梅花醉。' || text == '晚年时期' || text == '尽梅花无好意，赢得满衣清泪。' || text == '今年海角天涯，萧萧两鬓生华。' || text == '看取晚年风势，故应难看梅花。' ){
                    rightSelected()
                }else{
                   wrongSelected()
                }
            }

        }

        private function enterFrameHandler(e: Event):void{
            x -= speedX;
            if (x < -900) {
                removeEventListener (Event.ENTER_FRAME, enterFrameHandler);
            }
        }
        
        private function moveToPos(){
            addEventListener (Event.ENTER_FRAME, moveRepeat);
        }

        private function rightSelected():void{
            rightSound.play()
            moveToPos();
            dy += count2 * d; 
            trace("count2 , dx", count2, dx);
            count2++;
            if(count2  == 5){
                dispatchEvent(new MyEvent(MyEvent.ROOM_TEST3_OK));
                count2 = 0;
            }
            removeEventListener (Event.ENTER_FRAME, enterFrameHandler);
        }

        private function wrongSelected():void{
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


        private function moveRepeat(e: Event):void { 
            var dis = Math.sqrt((dx- x) * (dx - x) + (dy - y) * (dy - y));
            _cos = Math.abs(dx - x) / dis;
            _sin = Math.abs(dy - y) / dis;

            if( Math.abs(x-dx) <= 5 && Math.abs(y-dy) <= 5) {
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
