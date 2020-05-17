package  {
	import flash.events.Event;

	public class MyEvent extends Event {
    	//自定义事件，通知Main start场景完成
        public static const START_OVER:String = "startOver";

		//进入时期
		public static const INTO_PERIOD:String = "intoPeriod";

		//更新花朵
		public static const UPDATE_FLOWER:String = "updateFlower";

		// //更新对话
		// public static const UPDATE_TALK:String = "updateTalk";

		// test1 完成结束
		public static const TEST1_OK = "test1OK"
		// test1 未完成结束
		public static const TEST1_OVER = "test1Over"
		
        //构造函数
		public function MyEvent(type:String) {
			// constructor code
			super(type);
		}

	}
	
}
