package  {
	
	import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.utils.*; 
    import flash.filters.GlowFilter; 
    import flash.display.Stage; 
    // import flash.display.StageAlign; 
    import flash.display.StageScaleMode; 

	//存储公用变量及函数
	public class Global extends MovieClip {
        //通用发光对象
        const commonGlowObj = new GlowFilter(0xffffff,0.75,20,20)
        //阶段+诗对应花 
        //1: 梅花 2: 桂花 3:海棠 4: 荷花 5: 菊花
        const poemFlower = {
            1: [1, 2, 3],
            2: [1, 5, 4],
            3: [1, 5, 2]
        }
        
		// 哪一阶段哪一首诗
		public var period:int = 1;
		public var poem:int = 1;

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
	}
	
}
