package  {
	import flash.events.Event;

	public class MyEvent extends Event {
    	//自定义事件，通知Main start场景完成
        public static const START_OVER:String = "startOver";

		public static const NORMAL_MODE = "normalMode"

		//自定义事件，通知Main garden场景完成
        public static const GARDEN_OVER:String = "gardenOver";

		//进入时期
		public static const INTO_PERIOD:String = "intoPeriod";

		//更新花朵
		public static const UPDATE_FLOWER:String = "updateFlower";

		//更新养护液
		public static const UPDATE_LIQUID = "updateLiquid";

		// //更新对话
		// public static const UPDATE_TALK:String = "updateTalk";

		// test1 完成结束
		public static const TEST1_OK = "test1OK"
		// test1 未完成结束
		public static const TEST1_OVER = "test1Over"

		
		public static const ROOM_TEST2_OVER = "test2Over"
		public static const ROOM_TEST3_OK = "test3OK"
		public static const ROOM_TEST3_NEXT = "test3OK"

		public static const ADDITION_OVER = 'additionOver'
		public static const REPORT_OVER = 'reportOver'

        //构造函数
		public function MyEvent(type:String) {
			// constructor code
			super(type);
		}

	}
	
}
