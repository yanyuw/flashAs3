package {

    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.utils.*; 
    import flash.filters.GlowFilter; 

    public class Start extends Global {
        // 声明变量
        var wTrTimerid:uint

        public function Start() {
            super();

            this.stop();
            //首页按钮初始化
            initTitleBtn();
            //监听目前帧
            // addEventListener(Event.ENTER_FRAME, EFHandler);
            

            //跳过Start
            // addEventListener(MouseEvent.CLICK, function(e:Event) {
            //     //下一场景
            //     dispatchEvent(new MyEvent(MyEvent.START_OVER));
            // })
        }

        private function initTitleBtn():void {
            //hover发光
            hoverGlow(guideBtn);
            hoverGlow(startBtn);

			//事件监听
			// 课件指南按钮
			guideBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				clickSound.play()
                guidePopUp.guideVideo.play()
                guidePopUp.visible = true;
                hoverGlow(guidePopUp.closeBtn)
                guidePopUp.closeBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
                    guidePopUp.visible = false;
                    guidePopUp.guideVideo.stop()
                })
            })
            startBtn.addEventListener(MouseEvent.CLICK, function(e:Event) {
				clickSound.play()
                gotoAndStop(2)
                initModeBtn();
            })
        }

        private function initModeBtn():void {
            hoverGlow(plotModeBtn, new GlowFilter(0xcccc00, 0.75,20,20));
            plotModeBtn.addEventListener(MouseEvent.CLICK, function(e:Event) {
				clickSound.play()
                gotoAndStop(3)
                initTextArea()
                playBGM('zBGM')
            })

            hoverGlow(normalModeBtn, new GlowFilter(0xcccc00, 0.75,20,20))
            normalModeBtn.addEventListener(MouseEvent.CLICK, function(e:Event) {
				clickSound.play()
                dispatchEvent(new MyEvent(MyEvent.NORMAL_MODE));
                
            })
        }

        private function initTextArea():void {
            trace("当前帧", currentFrame);
            textArea.buttonMode = true;
            textArea.addEventListener(MouseEvent.CLICK, nextText);
        }

        //控制文本框
        private function nextText(e:Event):void {
            clickSound.play()
            if (currentFrame == 6) {
                gotoAndStop(currentFrame + 1)
                // trace("当前帧",currentFrame);

                //设置秘籍点击事件
                hoverGlow(book)
                book.addEventListener(MouseEvent.CLICK, function(e:Event) {
                    clickSound.play()
                    // trace("当前帧",currentFrame);
                    gotoAndStop(currentFrame + 1);

                    //设置秘籍内容点击事件
                    hoverGlow(bookContent)
                    bookContent.addEventListener(MouseEvent.CLICK, function(e:Event) {
                        clickSound.play()
                        // trace("当前帧",currentFrame);
                        stopBGM();
                        wTr.play();
                        wTrTimerid = setTimeout(trDelay, 500);
                    })
                })
            } else if (currentFrame == 13) {
                gotoAndStop(currentFrame + 1);

                //设置介绍点击事件
                introPopUp.buttonMode = true
                introPopUp.addEventListener(MouseEvent.CLICK, function(e:Event) {
                    clickSound.play()
                    trace("当前帧", currentFrame);
                    gotoAndStop(currentFrame + 1);
                })
            } else if (currentFrame == 17) {
                gotoAndStop(currentFrame + 1);

                //设置规则点击事件
                hoverGlow(rulesPopUp)
                rulesPopUp.addEventListener(MouseEvent.CLICK, function(e:Event) {
                    clickSound.play()
                    trace("当前帧", currentFrame);
                    //下一场景
                    dispatchEvent(new MyEvent(MyEvent.START_OVER));
                })
            } else if (currentFrame != 7) {
                trace("当前帧", currentFrame);
                gotoAndStop(currentFrame + 1)
            }

        }

        public function trDelay():void {
            gotoAndStop(currentFrame + 1)
            var tAreaTimerid:uint = setTimeout(function(){
                gotoAndStop(currentFrame + 1)
                
                playBGM('lBGM')
                clearTimeout(tAreaTimerid);
            }, 1000);
                        
            if(wTrTimerid > 0){
                clearTimeout(wTrTimerid);
            }
        }

    }
}
