package  {
	import flash.events.Event;

	public class MyEvent extends Event {
    	//自定义事件，通知Main start场景完成
        public static const START_OVER:String = "startOver";

		//进入时期
		public static const INTO_PERIOD:String = "intoPeriod";

		//更新花朵
		public static const FLOWER_UPDATE:String = "flowerUpdate";
		
        //构造函数
		public function MyEvent(type:String) {
			// constructor code
			super(type);
		}

	}
	
}
