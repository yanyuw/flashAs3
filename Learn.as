package  {
	import flash.events.MouseEvent;
    import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.FrameLabel;
    import flash.filters.GlowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	
	public class Learn extends Global {
		private var btnStatus = []
		private var btnGlowObj = new GlowFilter(0xFFB6C1, 0.5,20,20);
		private var textA:ScrollBarResizableTextArea = new ScrollBarResizableTextArea();
		private var progress = 0;
		private var visited = [];

		public function Learn() {
			
			init()
			// constructor code
		}

		public function setVisited(tab: int){
			visited[tab] = true;
		}
		
		private function init():void{
			// stop();
			trace('init in learn')

			visited = [false, false, false, false];
			//对选项卡初始化监听事件
			hoverGlow(learnTab, btnGlowObj)
			hoverGlow(explainTab, btnGlowObj)
			hoverGlow(talkTab, btnGlowObj)
			hoverGlow(appreTab, btnGlowObj)
			tabPlay(0);

			learnTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				gotoAndStop(1);//!
				tabPlay(0);
				firstTab(0);
				removeTextA()
			})
			explainTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				gotoAndStop(9);//!
				tabPlay(1);
				firstTab(1);
				removeTextA()
			})
			talkTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				gotoAndStop(10);//!
				tabPlay(2);
				firstTab(2);
				removeTextA()
				intoTalk();
			})
			appreTab.addEventListener(MouseEvent.CLICK, function(e:Event){
				gotoAndStop(11);//!
				tabPlay(3);
				firstTab(3);
				removeTextA()
			})
			//对按钮初始化
			btnStatus=[false, false, false, false]
			
			hoverGlow(originBtn, btnGlowObj)
			hoverGlow(transBtn, btnGlowObj)
			hoverGlow(tipBtn, btnGlowObj)
			hoverGlow(appreBtn, btnGlowObj)
			
			originBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				learnBtn(0)
			})
			transBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				learnBtn(1)
			})
			tipBtn.addEventListener(MouseEvent.CLICK, function(e:Event){
				learnBtn(2)
			})
			appreBtn..addEventListener(MouseEvent.CLICK, function(e:Event){
				learnBtn(3)
			})
		}

		private function firstTab(index){
			if(visited[index] == false){ // 第一次
				visited[index] = true;
				// trace(visited[index], index, visited)
				progress++;
				dispatchEvent(new MyEvent(MyEvent.FLOWER_UPDATE));
			}
		}

		private function learnBtn( btn: int):void{
			var buttonList = [originBtn, transBtn, tipBtn, appreBtn];
			// var startFrame = "原文"+period+"_"+poem //回到原文
			var startFrame:FrameLabel = currentLabels[poem+(period-1)*3-1]; 
			for(var i = 0; i < 4; i++){
				// trace('状态', i, btnStatus[i])
				// trace('i='+i, 'btn='+btn)
				if(i == btn){
					btnStatus[btn] = true;
					gotoAndStop(startFrame.frame+btn) //
					if(i == 3){
						newTextArea()
					}else{
						removeTextA()
					}
				}else{
					if(btnStatus[btn] == true){
						btnStatus[btn] = false;
					}
				}
			}
			
		}

		private function tabPlay(tab: int):void{
			var tabList = [learnTab, explainTab, talkTab, appreTab];
			for(var i = 0; i < tabList.length; i++){
				if(tab == i){
					tabList[i].gotoAndStop(2);
				}else{
					tabList[i].gotoAndStop(1);
				}
			}
		}


		private function removeTextA(){
			if(contains(textA)){
				removeChild(textA)	
			}
		}

		private function newTextArea():void{
			var cssText:String="p {font-size:22px; font-family:'Microsoft YaHei'; }";
			////////////
			var titleStyle:StyleSheet = new StyleSheet();
			titleStyle.parseCSS(cssText);

			textA.setSize(470,300);//必须添加，否则显示不正常，具体原因未查
			textA.move(180,30);
			
			textA.textField.styleSheet=titleStyle;//这里不再报错.
			
			textA.textField.width=470;
			textA.textField.height = 300;
			
			textA.htmlText=appreciation[poem+(period-1)*3-1];
			addChild(textA);
		}

		private function intoTalk():void{
		}

		private var appreciation = [
			'<p>咏物诗词一般以咏物抒情为主，绝少议论。李清照的这首咏桂词一反传统，以议论入词，又托物抒怀。咏物既不乏形象，议论也能充满诗意，堪称别开生面。“暗淡轻黄体性柔，情疏迹远只香留。”短短十四字却形神兼备，写出了桂花的独特风韵。上句重在赋“色”，兼及体性；下句重在咏怀，突出“香”字。据有关记载，桂树花白者名银桂，黄者名金桂，红者为丹桂。它常生于高山之上，冬夏常青，以同类为林，间无杂树。又秋天开花者为多，其花香味浓郁。色黄而冠之以“轻”，再加上“暗淡”二字，说明她不以明亮炫目的光泽和秾艳娇媚的颜色取悦于人。虽色淡光暗，却秉性温雅柔和，像一位恬静的淑女，自有其独特的动人风韵。令人爱慕不已。她又情怀疏淡，远迹深山，惟将浓郁的芳香常飘人间，犹如一位隐居的君子，以其高尚的德行情操，赢得了世人的敬佩。</p><p>“暗淡轻黄体性柔，情疏迹远只香留。”形神兼备地写出了桂花的独特风韵。她的颜色并不艳丽，“暗淡轻黄”，与很多名花相比，外表逊色得多。她的社会声望也很一般，“情疏迹远”，并没有得到什么荣耀和宠幸，更不会有人给她热捧恭维。但是她的体性温柔，香留天地之间。</p><p>“何须浅碧轻红色，自是花中第一流。”从这两句起直至歇拍，都是以议论的方式行文。这两句是议论的第一层。花当然是以红为美的。至于碧牡丹、绿萼梅之类，那就更为名贵了。这些都是桂花没有具备的。但是作者认为，内在美，比外在美更为重要。“何须”二字，把各种名花一笔荡开，突出了色淡香浓、迹远品高的桂花，断定她是“花中第一流”。</p><p>“梅定妒，菊应羞，画栏开处冠中秋。”这是议论的第二层。梅花既有妍丽的外美，更有迎霜雪而开的高洁的内美。菊花更是人所共同认可的“君子之花”，兼具内外之美。但是这两种名花，在桂花的面前都自叹不如，都产生了羞愧和妒忌的心理。经过这样的比较抑扬，桂花的定位就很清楚了。所以作者论定：桂花是众多的秋季名花之冠。</p><p>“骚人可煞无情思，何事当年不见收。”这是议论的第三层。“骚人”，指屈原。屈原在《离骚》中，用褒扬之笔，列举了各种各样的香草名花，以比况君子修身美德，可是偏偏没有提到桂花。所以作者抱怨他“可煞无情思”。屈原的人品和才德，是人所共同景仰的，这也包括作者李清照在内。对这位先贤的抱怨，更突出了作者对桂花的珍重。</p><p>李清照的这首咏物词咏物而不滞于物。草间或以群花作比，或以梅菊陪衬，或评骘古人，从多层次的议论中，形象地展现了她那超尘脱俗的美学观点和对桂花由衷的赞美和崇敬。桂花貌不出众，色不诱人，但却“暗淡轻黄”、“情疏迹远”而又馥香自芳，这正是词人品格的写照。这首词显示了词人卓尔不群的审美品味，值得用心玩味。</p>',
			'<p>上片荡完秋千的精神状态。词人不写荡秋千时的欢乐，而是剪取了“蹴罢秋千”以后一刹那间的镜头。</p><p>此刻全部动作虽已停止，但仍可以想象得出少女荡秋千时的情景，罗衣轻飏，像燕子一样地空中飞来飞去，妙静中见动。“起来慵整纤纤手”，“慵整” 二字用得非常恰切，从秋千上下来后，两手有些麻，却又懒得稍微活动一下，写出少女的娇憨。“纤纤手” 语出《古诗十九首》：“娥娥红粉妆，纤纤出素手。”借以形容双手的细嫩柔美，同时也点出人物的年纪和身份。“薄汗轻衣透”，她身穿“轻衣”，也就是罗裳初试，由干荡秋千时用力，出了一身薄汗，额上还渗有晶莹的汗珠。这份娇弱美丽的神态恰如娇嫩柔弱的花枝上缀着一颗颗晶莹的露珠。“露浓花瘦”一语既表明时间是春天的早晨，地点是花园也烘托了人物娇美的风貌。整个上片以静写动，以花喻人，生动形象地勾勒出一少女荡完秋千后的神态。</p><p>下片写少女乍见来客的情态。她荡完秋千，正累得不愿动弹，突然花园里闯进来一个陌生人。“见客入来”，她感到惊诧，来不及整理衣装，急忙回避。</p><p>“袜刬”，指来不及穿鞋子，仅仅穿着袜子走路。“金钗溜”，是说头发松散，金钗下滑坠地，写匆忙惶遽时的表情。词中虽未正面描写这位突然来到的客人是谁，但从词人的反应中可以印证，他定是一位翩翩美少年。“和羞走”三字，把她此时此刻的内心感情和外部动作作了精确的描绘。“和羞”者，含羞也：“走”者，疾走也。然而更妙的是“倚门回首，却把青梅嗅”二句。它以极精湛的笔墨描绘了这位少女怕见又想见、想见又不敢见的微妙心理。最后她只好借“嗅青梅”这一细节掩饰一下自己，以便偷偷地看他几眼。下片以动作写心理，几个动作层次分明，曲折多变，把一个少女惊诧、惶遽、含羞、好奇以及爱恋的心理活动，栩栩如生地刻划出来。唐人韩偓《竿奁集》中写过类似的诗句：“见客入来和笑走，手搓梅子映中门。”但相比之下，“和笑走”见轻薄，“和羞走”现深挚：“手搓梅子”只能表现不安，“却把青梅嗅”则可描画矫饰：“映中门”似旁若无人，而“倚门”则有所期待，加以“回首”一笔，少女窥人之态婉然眼前。</p><p>这首词写少女情况心态，虽有所本依，但却能青出于蓝而胜于蓝，获“曲尽情悰”之誉。</p>'
		]

	}
	
}
