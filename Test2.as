package  {
	
	import flash.display.MovieClip;
	
	import flash.utils.*; 
	import flash.events.MouseEvent;
    import flash.events.Event;
	
	public class Test2 extends Global {
		public var posX = [85, 160, 230, 350, 420, 490, 605, 680, 750];
		public var posY = 290;
		public var selectFlower = [];
		public var test2Answer = [['meihua1', 'guihua2', 'haitang'], ['hehua', 'juhua1', 'meihua2'], ['meihua3', 'juhua2', 'guihua1']]
		
		public function Test2() {
			// constructor code
			
			// test2Answer[0].sort();
			// test2Answer[1].sort();
			// test2Answer[2].sort();
			// trace(test2Answer)
		}

		public function initTest2Content(){
			//花初始化
			hoverGlow(meihua1);
			hoverGlow(meihua2);
			hoverGlow(meihua3);

			hoverGlow(guihua1);
			hoverGlow(guihua2);

			hoverGlow(juhua1);
			hoverGlow(juhua2);

			hoverGlow(haitang);
			hoverGlow(hehua);

			//海棠
			haitang.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			haitang.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			haitang.startPosX = haitang.x;
			haitang.startPosY = haitang.y;

			//荷花
			hehua.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			hehua.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			hehua.startPosX = hehua.x;
			hehua.startPosY = hehua.y;

			//梅花
			meihua1.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			meihua1.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			meihua1.startPosX = meihua1.x;
			meihua1.startPosY = meihua1.y;

			meihua2.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			meihua2.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			meihua2.startPosX = meihua2.x;
			meihua2.startPosY = meihua2.y;

			meihua3.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			meihua3.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			meihua3.startPosX = meihua3.x;
			meihua3.startPosY = meihua3.y;

			//桂花
			guihua1.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			guihua1.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			guihua1.startPosX = guihua1.x;
			guihua1.startPosY = guihua1.y;

			guihua2.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			guihua2.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			guihua2.startPosX = guihua2.x;
			guihua2.startPosY = guihua2.y;

			//菊花
			juhua1.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			juhua1.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			juhua1.startPosX = juhua1.x;
			juhua1.startPosY = juhua1.y;
			
			juhua2.addEventListener(MouseEvent.MOUSE_DOWN, startDragEvent);
			juhua2.addEventListener(MouseEvent.MOUSE_UP, stopDragEvent);
			juhua2.startPosX = juhua2.x;
			juhua2.startPosY = juhua2.y;

		}

		private function startDragEvent(e: MouseEvent):void{
			var obj: MovieClip = e.currentTarget as MovieClip;
			obj.startDrag();
		}

		private function stopDragEvent(e: MouseEvent):void{
			var obj: MovieClip = e.currentTarget as MovieClip;
			obj.stopDrag();
			

			if(obj.hitTestObject(pos1_1)){
				hitPos(obj, 0)
			} else if(obj.hitTestObject(pos1_2)){
				hitPos(obj, 1)
			}else if(obj.hitTestObject(pos1_3)){
				hitPos(obj, 2)
			}else if(obj.hitTestObject(pos2_1)){
				hitPos(obj, 3)
			}else if(obj.hitTestObject(pos2_2)){

				hitPos(obj, 4)
			}else if(obj.hitTestObject(pos2_3)){

				hitPos(obj, 5)
			}else if(obj.hitTestObject(pos3_1)){

				hitPos(obj, 6)
			}else if(obj.hitTestObject(pos3_2)){
				
				hitPos(obj, 7)
			}else if(obj.hitTestObject(pos3_3)){

				hitPos(obj, 8)
			}else{
				unselecteFlower(obj.name)
				obj.x = obj.startPosX;
				obj.y = obj.startPosY;
			}
		}

		private function hitPos(obj: MovieClip ,idx):void{
			obj.x = posX[idx];
			obj.y = posY;
			returnPos(idx, obj.name);
			selectFlower[idx] = obj.name;
			if(completeSelect() == true){
				submitPop.visible = true;
				submitPop.gotoAndStop(1);
				
				hoverGlow(submitPop.submitBtn)
				hoverGlow(submitPop.returnBtn)

				submitPop.submitBtn.addEventListener(MouseEvent.CLICK, checkAnswer)
				submitPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
					submitPop.visible = false;
				})
			}
		}

		private function returnPos(idx, name):void{
			trace(selectFlower)
			if(selectFlower[idx] != undefined && selectFlower[idx].length > 0 && selectFlower[idx] != name){
				this[selectFlower[idx]].x = this[selectFlower[idx]].startPosX
				this[selectFlower[idx]].y = this[selectFlower[idx]].startPosY
			}
			
		}

		private function unselecteFlower(flower):void{
			for(var f = 0; f < 9; f++){
				if(selectFlower[f] == flower){
					selectFlower[f] = undefined;
				}
			}
		}


		private function checkAnswer(e: MouseEvent):void{
			var answer1 = selectFlower.slice(0, 3).sort()
			var answer2 = selectFlower.slice(3, 6).sort()
			var answer3 = selectFlower.slice(6, 9).sort()

			trace(answer1, answer2, answer3)

			test2Answer[0].sort();
			test2Answer[1].sort();
			test2Answer[2].sort();
			trace(test2Answer[0], test2Answer[1], test2Answer[2]);

			if(test2Answer[0].toString() == answer1.toString() && test2Answer[1].toString() == answer2.toString() && test2Answer[2].toString() == answer3.toString()){
				//答对
				submitPop.gotoAndStop(2);
				test2Result = true;
				
				submitPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
					dispatchEvent(new MyEvent(MyEvent.ROOM_TEST2_OVER));
				})
			}else{
				//答错				
				submitPop.gotoAndStop(3);
				submitPop.returnBtn.addEventListener(MouseEvent.CLICK, function(e: Event){
					dispatchEvent(new MyEvent(MyEvent.ROOM_TEST2_OVER));
				})
			}
		}

		
		private function completeSelect():Boolean{
			for(var f = 0; f < 9; f++){
				trace(f, selectFlower[f])
				if(selectFlower[f] == undefined){
					return false;
				}
			}
			return true;
		}
	}
	
}
