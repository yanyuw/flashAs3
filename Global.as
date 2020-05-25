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
        public static var starTest = [false, false, false, false, false, false, false];

        //养护液数量
        public static var liquidCount = 0;

        //提炼室做过题目
        public static var roomTestDone = [false, false, false];
    
        //题目
        public static var periodTestResult = [false, false, false];

        //roomtest1
        public static var test1Result = false;
        
        //roomtest2
        public static var test2Result = false;

        //roomtest3
        public static var nowVideo = 1;
        public static var test3Result = false;

        //加试题目
        public static var hasAddition = false;
        public static var additionTestNum = 0;
        public static var subAdditionTestNum = 0;
        public static var additionTestResult = false;

        //结局
        public static var isGoodEnding = false;

        //问题
        public static var finalResult = false;
        
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
        //测试内容
        var testContent = [
            'I文字雨\n【题目】诗句：知否，知否？应是绿肥红瘦。对应的花朵、时期及意象是什么？\n【答案】海棠、少女时期、对春光易逝的感叹',
            'Ⅱ李清照的朋友圈\n【题目】假如李清照来到了你的世界，接触了微信，你认为哪句诗会出现在中年时期的李清照的朋友圈里呢？\nA 满地黄花堆积，憔悴损，如今有谁堪摘？\nB 何须浅碧深红色，自是花中第一流。\nC 莫道不销魂，帘卷西风，人比黄花瘦。\n【答案】C',
            'Ⅲ超时空对话\n【题目】晚年的李清照看到少年时期的自己在本子中写下的“何须浅碧深红色，自是花中第一流”诗句，感慨时光飞逝，心境不复从前，挥笔写下：菁菁年少，如此美好！而现如今的我，却只能“_______”。\nA 红藕香残玉簟秋，轻解罗裳，独上兰舟\nB 病起萧萧两鬓华，卧看残月上窗纱\nC 泪染轻匀，犹带彤霞晓露痕\n【答案】B',
            '【允客之求】\n【题目】象征着“幸福甜蜜”的花朵是？象征着“卓尔不群”的花朵是？\n【答案】梅花、桂花\n\n【题目】象征着“浓郁情思”的花朵是？象征着“叹春自怜” 的花朵是？\n【答案】菊花、海棠\n\n【题目】象征着“爱恋羞涩”的花朵是？象征着“相思之苦”的花朵是？\n【答案】梅花、荷花',
            '【人生花谱】\n梅花（3瓣分别是）：爱恋羞涩 幸福甜蜜 深忧国衰\n菊花（2瓣分别是）：浓郁情思 悲惨凄沧\n桂花（2瓣分别是）：卓尔不群 平静淡然\n荷花（1瓣）：相思之苦\n海棠（1瓣）：叹春自怜\n\nⅠ悠悠流香花烂漫（少女时期/早期）\n①梅花-爱恋羞涩\n②桂花-卓尔不群\n③海棠-叹春自怜\n\nⅡ幽幽纷杂花百态（少妇时期/中期）\n①荷花-相思之苦\n②菊花-浓郁情思\n③梅花-幸福甜蜜\n\nⅢ忧忧瓣落花已尽（晚年时期/晚期）\n①梅花-深忧国衰\n②菊花-悲惨凄沧\n③桂花-平静淡然',
            '【往事回首】\n（视频：鹧鸪天）\n	诗句（在弹幕中以此点击出来下面这四句诗）：\n暗淡轻黄体性柔，情疏迹远只香留。何须浅碧深红色，自是花中第一流。\n梅定妒，菊应羞，画栏开处冠中秋。骚人可煞无情思，何事当年不见收。\n	时期：少女时期\n\n（视频：清平乐）\n	诗句（在弹幕中以此点击出来下面这四句诗）：\n年年雪里，常插梅花醉。 尽梅花无好意，赢得满衣清泪。\n今年海角天涯，萧萧两鬓生华，看取晚年风势，故应难看梅花。\n时期：晚年时期'
        ]

        //加试内容
		var additionQ = [
			'【题目】诗句“知否，知否？应是绿肥红瘦”对应的花朵、时期及意象是什么？',
			'【题目】假如李清照来到了你的世界，接触了微信，你认为哪句诗会出现在中年时期的李清照的朋友圈里呢？',
			'【题目】晚年的李清照看到少年时期的自己在本子中写下的“何须浅碧深红色，自是花中第一流”诗句，感慨时光飞逝，心境不复从前，挥笔写下：菁菁年少，如此美好！而现如今的我，却只能“_______”。',
			[
				'【题目】象征着“幸福甜蜜”的花朵是？；象征着“卓尔不群”的花朵是？',
				'【题目】象征着“浓郁情思”的花朵是？象征着“叹春自怜” 的花朵是？',
				'【题目】象征着“爱恋羞涩”的花朵是？象征着“相思之苦”的花朵是？'
			],
			'',
			[
				'【题目】《鹧鸪天》描写的花朵是（），意象含义是（），属于李清照（）时期的作品',
				'【题目】《清平乐》描写的花朵是（），意象含义是（），属于李清照（）时期的作品'
			]
		];
		var additionO = [
			[
				'A. 海棠；少女时期；叹春自怜',
				'B. 海棠；少妇时期；幸福甜蜜',
				'C. 梅花；少女时期；幸福甜蜜',
				'D. 梅花；少妇时期；叹春自怜',
			],
			[
				'A. 满地黄花堆积，憔悴损，如今有谁堪摘？',
				'B. 何须浅碧深红色，自是花中第一流。',
				'C. 莫道不销魂，帘卷西风，人比黄花瘦。',
			],
			[
				'A. 红藕香残玉簟秋，轻解罗裳，独上兰舟',
				'B. 病起萧萧两鬓华，卧看残月上窗纱',
				'C. 泪染轻匀，犹带彤霞晓露痕'
			],
			[
				[
					'A. 梅花、荷花',
					'B. 梅花、桂花',
					'C. 菊花、海棠',
				],
				[
					'A. 菊花、荷花',
					'B. 梅花、桂花',
					'C. 菊花、海棠',
				],
				[
					'A. 梅花、荷花',
					'B. 梅花、桂花',
					'C. 菊花、海棠',
				]
			],
			[],
			[
				[
					'A. 桂花；卓尔不群；少女时期',
					'B. 梅花；叹春自怜；少女时期',
					'C. 荷花；平静淡然；晚年时期',
				],
				[
					'A. 桂花；卓尔不群；少女时期',
					'B. 梅花；深忧国衰；晚年时期',
					'C. 荷花；平静淡然；晚年时期'
				]

			]
		];
		var additionAnswer = ['A','C','B',['B','C','A'],'',['A','B']]
	}
	
}
