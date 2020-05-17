package  {
	
	import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.utils.*; 
    import flash.filters.GlowFilter; 
    import flash.display.Stage; 
    // import flash.display.StageAlign; 
    import flash.display.StageScaleMode;
	import flash.text.TextField; 
    import flash.ui.Mouse;

	//存储公用变量及函数
	public class Global extends MovieClip {
        //通用发光对象
        const commonGlowObj = new GlowFilter(0xffffff,0.75,20,20)
        //阶段+诗对应花 
        //1: 桂花 2: 梅花 3:海棠 4: 荷花 5: 菊花
        const poemFlower = {
            1: [1, 2, 3],
            2: [2, 5, 4],
            3: [2, 5, 1]
        }


		// 哪一阶段哪一首诗
		public static var period:int = 1;
		public static var poem:int = 1;

        // 已经回答
        public static var alreadyAsk = [false, false, false, false, false, false, false, false, false];

        // 题目收藏情况
        public static var starTest = [false, false, false];
        
		public function Global() {
			// constructor code
            stage.scaleMode = StageScaleMode.EXACT_FIT 
		}

        //hover发光
        public function hoverGlow(button, glowObj=null) {
            if(glowObj == null){
                glowObj = commonGlowObj;
            }
			button.buttonMode = true;
            var filters:Array = button.filters
            var newFilters:Array = button.filters;
            newFilters.push(glowObj)
            
            button.addEventListener(MouseEvent.MOUSE_MOVE, function() {
                button.filters= newFilters;
            })
            button.addEventListener(MouseEvent.MOUSE_OUT, function() {
                button.filters=filters;
            })
		}

        //发光
        public function addGlow(button, glowObj=null) {
			button.buttonMode=true
            if(glowObj == null){
                glowObj = commonGlowObj;
            }
            button.filters=[glowObj];
		}

        //取消发光
        public function removeGlow(button, removeBtnMode = false) {
            if(removeBtnMode){
                button.buttonMode=false
            }
            button.filters=[];
		}


        public function tfHover(tf: TextField):void{
            tf.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            tf.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut); 
            function onMouseOver(e:MouseEvent) { 
                Mouse.cursor="button";       //当鼠标移到动态文本上时出现手形
            }
            function onMouseOut(e:MouseEvent) {        
                Mouse.cursor="arrow";        //当鼠标离开动态文本时取消手形,恢复为箭头
            }
        }
	}
	
}
