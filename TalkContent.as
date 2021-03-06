﻿package  {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
    import flash.utils.*; 
	import flash.events.MouseEvent;
    import flash.events.Event;
	import fl.controls.UIScrollBar;
	
	public class TalkContent extends Global {
		private var textWidth;
		private var textHeight;
		
		public function TalkContent() {
			// constructor code
			super()
			init();
		}

		private function init():void{
			left.visible = false;
			right.visible = false;
			initTextField();
		}

		private function initTextField():void{
			left.textArea.autoSize = TextFieldAutoSize.LEFT;
			right.textArea.autoSize = TextFieldAutoSize.LEFT;
		}
		

		public function setContent(questionText: String, questionID, aSp):void{
			setText(right, questionText)
			var answerTimerID = setTimeout(function(){
				var answerText = answer[poem+(period-1)*3-1][questionID-1]
				
				trace(poem+(period-1)*3-1, questionID-1, answerText)
				setText(left, answerText)
				
				aSp.update()
				if(answerTimerID > 0){
					clearTimeout(answerTimerID);
				}
			}, 500);
		}

		private function setText(mc, text):void{
			mc.visible = true;
			mc.textArea.htmlText = text;
			resize(mc);
		}

		public function resize(mc):void{
			textWidth = mc.textArea.width;
			textHeight = mc.textArea.height;
			// trace('宽高',textWidth, textHeight);
			mc.base.height = textHeight+16;
		}
		
		
		private var answer = [
			//《鹧鸪天》（卓尔不群）
			[
				//问题一：这首诗咏颂的是什么花？在诗中有什么代表意象？（必选）
				'<font size="+2" color="#ff3333" ><b>【桂花—卓尔不群】</b></font> \n这是一首咏桂词，从多层次的议论中，形象地展现了我对桂花由衷的赞美和崇敬。桂花貌不出众，色不诱人，但却“暗淡轻黄”、“情疏迹远”而又馥香自芳，我并不仅仅是在歌咏桂花，也是在以桂花自喻。我把桂花视作“花中第一流”，也是把人的内在美、人格美视作最高的人生境界，具有这种人生境界的人，也才是“第一流”的人。我希望自己也能拥有如桂花一般的品性。',
			],
			//《点绛唇》（爱恋羞涩）
			[
				//问题一：为什么是“和羞走”？ 
				'来的是一位翩翩美少年，也就是我后来的丈夫赵明诚。那也是我和他第一次见面的情景，我当时有一种怕见又想见、想见又不敢见的微妙心理，所以才用了“和羞走”表达当时自己的内心感情和外部动作。“倚”“回”“嗅” 三个动作，不仅折射出我的动作、神情、姿态，而且描绘出我当时既爱恋又羞涩、既欣喜又紧张、既兴奋又恐惧的微妙心理活动。',
				//“青梅”在这首诗里的特殊含义是什么？（必选）
				'<font size="+2" color="#ff3333" ><b>【梅花—爱恋羞涩】</b></font>\n我当时没有乖乖地回屋关上门，而是倚在门边回头张望，我一边假装嗅着青梅散发的清香气息，一边借梅枝挡着因为惊喜而泛红的面容，有意无意掩饰自己的娇羞和心事。酸涩却又带有点点清香的青梅是我当时心中的感受，我和我丈夫的第一次见面就像那青梅一样，留有最初爱情的味道。',
				//词牌名“点绛唇”的由来是什么？
				'此调由冯延巳创调，调名来自江淹《咏美人春游诗》中“白雪凝琼貌，明珠点绛唇”一句，它并不是把整个香唇涂满胭脂，而是在上下唇中间各点上一个红点，所以叫做“点”绛唇。'
			],
			//《如梦令》（叹春自怜）
			[
				//这首诗中“海棠”有什么代表意象？（必选）
				'<font size="+2" color="#ff3333" ><b>【海棠—叹春自怜】</b></font>\n这里的海棠意象是对于自我的映照。宝贵的青春被封建礼俗摧残耗尽，如同这海棠一样。在别人眼中，我是一代才女，而只有我自己知道春光短暂、年华易逝，自己的身心已如同这风雨过后的海棠花，没有了少女时代的快乐、天真与烂漫，接踵而至的是对春光易逝的感叹和对时光命运的忧伤与自怜。',
			],
			//《减字木兰花》（幸福甜蜜）
			[
				//问题一：这首诗中的花有什么代表意象？（必选）
				'<font size="+2" color="#ff3333" ><b>【梅花—幸福甜蜜】</b></font>\n这首词作于建中靖国年间，那个时候我与夫君赵明诚正是新婚燕尔，我与梅花的“比美”也凸显了我们新婚生活的温馨甜蜜以及对生活的热爱。那段时光，真的很美满啊！'
			],
			//《醉花阴》（浓郁情思）
			[
				//问题一：这首诗中的“黄花”有什么代表意象？（必选）
				'<font size="+2" color="#ff3333" ><b>【菊花—浓郁情思】</b></font>\n“黄花”就是菊花，那时丈夫在汴京担任鸿胪少卿一职，我独守空闺，饱受相思的折磨，在诗中我以花木之“瘦”，比人之瘦，希望把相思之苦借黄花这一意象表说，透露我当时浓郁的情思。'
			],
			//《一剪梅》（相思之苦）
			[
				//问题一：词牌名“一剪梅”的由来是什么？
				'“一剪梅”最初是《诗经·周南》中记载的一个故事。一个美丽的姑娘，站在一片梅林中，望着树上已经成熟的梅子，有的已经熟透掉在了地上，仅剩下七成梅子还留在树上，过不了几天，就会都纷纷落下了。她思念心中的恋人，不禁暗自着急，自言自语地说：“你还等什么呢？要是再不向我求爱，我就要成为别人的新娘了。”后来由于周邦彦根据这个曲调填的词，其中第一句是“一剪梅花万样娇”，所以就把这个词牌定为“一剪梅”。在宋代，人们称一枝为一剪。一剪梅的意思，就是一枝梅花。古代时候，相隔两地的人往往通过赠送对方一枝梅花来表达相思。',
				//问题二：“红藕”在这首诗里的特殊含义是什么？（必选）
				'<font size="+2" color="#ff3333" ><b>【荷花—相思之苦】</b></font>\n“红藕”是指红色的荷花，昔日盛开的荷花已经香消凋残，满眼尽是清秋冷落，我就像那荷花，青春易逝，红颜易老，与丈夫相思却又不能相见，愁的很啊！',
			],
			//《清平乐》（深忧国衰）
			[
				//问题一：“梅花”在这首诗里的特殊含义是什么？（必选）
				'<font size="+2" color="#ff3333" ><b>【梅花—深忧国衰】</b></font>\n词人借咏梅表现国破家亡、沦落天涯的痛苦，寄托词人对国势衰颓的深沉忧虑。 我截取了自己早年、中年、晚年三个不同时期赏梅的典型画面，早年是“常插梅花醉”，中年是“捋尽梅花无好意”，晚年是“难看梅花”，深刻表现自己早年的欢乐，中年的悲戚幽怨，以及晚年的沦落，这是对我生活的概括和总结。“梅花”是美好事物的象征，“难看梅花”则是指国家遭难，而且颇有禁受不住之势，此情此景，我那里还有赏梅的闲情逸致呢？我借咏梅表现国破家亡、沦落天涯的痛苦，寄托我对国势衰颓的深沉忧虑。'
			],
			//《声声慢》（悲惨凄沧）
			[
				//问题一：本首诗与《醉花阴》都提及了黄花，两首诗中的“黄花”象征意有什么不同呢？（必选）
				'<font size="+2" color="#ff3333" ><b>【菊花—悲惨凄沧】</b></font>\n《声声慢》这首诗里的“满地黄花堆积”是指菊花盛开，而不是残英满地。但我身心憔悴，所以无心采摘，在为眼前美景的命运感到忧伤的同时，我也感受到了人如憔悴黄花般无人问津的悲惨凄沧，生死离别给我的心灵带来的沉痛无以言说，我对国破家亡、社会动荡的现状在当时也有着非常深切的感受。',
				//问题二：最开始的叠词有什么作用？
				'宋词是用来演唱的，因此音调和谐是一个很重要的内容。我对音律有很深的兴趣，就赋予了这几组叠词音乐美。开篇“寻寻觅觅”侧重写行为，表达了我当时心中若有所失、孤寂空虚的精神状态。 “寻寻觅觅”四字，顿顿跌跌，情附于形，渲染了情境，如果仅用“寻觅”二字就显单薄，没有这种效果了。在“寻觅”一番后，什么也没得到，感到“冷冷清清”，境界更凄寂。“冷冷清清”侧重写的是状态，既是清冷环境的描写，又是我抑郁寂寞、心事难照的心态描写，四个字既明写了环境，又暗示了心情。“凄凄惨惨戚戚”纯粹描绘内心感觉，是我当时坐卧不宁、衷肠难述的悲凉心境的形象化描写。',
			],
			//《摊破浣溪沙》（平静淡然）
			[
				//问题一：“木樨花”在这首诗里的特殊含义和《鹧鸪天》中有什么不同？（必选）
				'<font size="+2" color="#ff3333" ><b>【桂花—平静淡然】</b></font>\n从词中可以看出，经历了“忧患得失，何其多也”的我，对桂花依然情有独钟。这首词中的木樨花其实就是晚年我的心态的真实写照，对于曾经“自是花中第一流”但又经历了欢乐、悲恸、繁华、寂寞的我来说，如今是绚丽之后归于平淡了，但内蕴也更丰富了。',
				//问题二：整首诗的情感基调是什么？
				'这首词创作于我的晚年，是一首抒情词，主要写我病后的生活情状，词中所述多为寻常之事、自然之情，淡淡推出，却起扣人心弦之效。这首词心境比较平和，与同时期其他作品很不相同。',
				//问题三：词牌名“摊破浣溪沙”的由来是什么？
				'摊破浣溪沙是词牌名，其实就是“浣溪沙”的别体。浣溪沙原为唐代教坊曲名，因春秋时期“西施浣纱于若耶溪”而得名，后用作词牌名，又名《浣溪纱》《小庭花》等。'
			]
		]
		
		
	}
	
}
