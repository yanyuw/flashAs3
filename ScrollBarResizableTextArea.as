
package {

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.events.TextEvent;
    import flash.events.FocusEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.getQualifiedClassName;
    import flash.text.TextFieldType;

    import fl.controls.TextArea;
    import fl.events.ScrollEvent;
    import fl.controls.ScrollPolicy;
    import fl.controls.ScrollBarDirection;
    import fl.managers.IFocusManager;
    import fl.core.UIComponent;
    import fl.controls.UIScrollBar;


    public class ScrollBarResizableTextArea extends TextArea {

        //从TextArea拷贝过来的样式
        protected static const SCROLL_BAR_STYLES:Object = {downArrowDisabledSkin: "downArrowDisabledSkin",
                downArrowDownSkin: "downArrowDownSkin",
                downArrowOverSkin: "downArrowOverSkin",
                downArrowUpSkin: "downArrowUpSkin",
                upArrowDisabledSkin: "upArrowDisabledSkin",
                upArrowDownSkin: "upArrowDownSkin",
                upArrowOverSkin: "upArrowOverSkin",
                upArrowUpSkin: "upArrowUpSkin",
                thumbDisabledSkin: "thumbDisabledSkin",
                thumbDownSkin: "thumbDownSkin",
                thumbOverSkin: "thumbOverSkin",
                thumbUpSkin: "thumbUpSkin",
                thumbIcon: "thumbIcon",
                trackDisabledSkin: "trackDisabledSkin",
                trackDownSkin: "trackDownSkin",
                trackOverSkin: "trackOverSkin",
                trackUpSkin: "trackUpSkin",
                repeatDelay: "repeatDelay",
                repeatInterval: "repeatInterval"};


        public function ScrollBarResizableTextArea() {
            // constructor code
            super();
        }

        override protected function configUI():void {
            //从UIComponent拷贝过来的代码
            isLivePreview = checkLivePreview();
            var r:Number = rotation;
            rotation = 0;
            var w:Number = super.width;
            var h:Number = super.height;
            super.scaleX = super.scaleY = 1;
            setSize(w, h);
            move(super.x, super.y);
            rotation = r;
            startWidth = w;
            startHeight = h;
            if (numChildren > 0) {
                removeChildAt(0);
            }

            //从TextArea拷贝过来的代码并作适当修改
            tabChildren = true;

            textField = new TextField();
            addChild(textField);
            updateTextFieldType();

            _verticalScrollBar = new UIScrollBar();
            _verticalScrollBar.name = "V";
            _verticalScrollBar.visible = false;
            _verticalScrollBar.focusEnabled = false;
            copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);
            _verticalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
            addChild(_verticalScrollBar);

            _horizontalScrollBar = new UIScrollBar();
            _horizontalScrollBar.name = "H";
            _horizontalScrollBar.visible = false;
            _horizontalScrollBar.focusEnabled = false;
            _horizontalScrollBar.direction = ScrollBarDirection.HORIZONTAL;
            copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
            _horizontalScrollBar.addEventListener(ScrollEvent.SCROLL, handleScroll, false, 0, true);
            addChild(_horizontalScrollBar);

            textField.addEventListener(TextEvent.TEXT_INPUT, handleTextInput, false, 0, true);
            textField.addEventListener(Event.CHANGE, handleChange, false, 0, true);
            textField.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown, false, 0, true);

            _horizontalScrollBar.scrollTarget = textField;
            _verticalScrollBar.scrollTarget = textField;
            addEventListener(MouseEvent.MOUSE_WHEEL, handleWheel, false, 0, true);

        }

        public function setScrollBarSize(__width:Number):void {
            horizontalScrollBar.setSize(__width, height);
            verticalScrollBar.setSize(__width, height);
            draw();
        }

        override protected function drawLayout():void {
            super.drawLayout();
        }

        override protected function focusOutHandler(event:FocusEvent):void {
            //从TextArea拷贝过来的代码并作适当修改
            var fm:IFocusManager = focusManager;
            if (fm) {
                fm.defaultButtonEnabled = true;
            }
            //setSelection(0, 0);
            super.focusOutHandler(event);

            if (editable) {
                setIMEMode(false);
            }
        }

        /**
         * @private (protected)
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
         */
        override protected function drawTextFormat():void {
            //从TextArea拷贝过来的代码并作适当修改，将setTextFormat语句全部放在try...catch块中以避免错误的发生
            // Apply a default textformat
            var uiStyles:Object = UIComponent.getStyleDefinition();
            var defaultTF:TextFormat = enabled ? uiStyles.defaultTextFormat as TextFormat : uiStyles.defaultDisabledTextFormat as TextFormat;
            try {
                textField.setTextFormat(defaultTF);
            } catch (e:Error) {

            }
            var tf:TextFormat = getStyleValue(enabled ? "textFormat" : "disabledTextFormat") as TextFormat;
            if (tf != null) {
                try {
                    textField.setTextFormat(tf);
                } catch (e:Error) {

                }
            } else {
                tf = defaultTF;
            }
            try {
                textField.defaultTextFormat = tf;
            } catch (e:Error) {

            }
            setEmbedFont();
            if (_html) {
                textField.htmlText = _savedHTML;
            }
        }


    }

}

