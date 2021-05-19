import 'package:custom_button_with_slider/thumb_custom_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double sliderWidth;
  final double sliderHeight;
  // final Color initialColor;
  // final Color changeColor;
  final Color color;
  final Color thumbColor;
  final Color borderColor;
  final double thumbHeight;
  final double thumbWidth;
  final double cornerRadius;
  final double elevation;
  final String initialLevelText;
  final String changeLevelText;
  final Color initialTextColor;
  final Color changeTextColor;
  final Function onTapFun;

  const CustomButton({
    @required this.onTapFun,
    this.sliderWidth = 150.0,
    this.sliderHeight = 60.0,
    // this.initialColor = Colors.deepOrange,
    // this.changeColor = Colors.blueAccent,
    this.color = Colors.blueAccent,
    this.thumbColor = Colors.grey,
    this.thumbHeight = 40.0,
    this.thumbWidth = 16.0,
    this.cornerRadius = 12.0,
    this.borderColor = Colors.grey,
    this.elevation = 8.0,
    this.initialLevelText = 'Text-1',
    this.changeLevelText = 'Text-2',
    this.initialTextColor = Colors.black,
    this.changeTextColor = Colors.white,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double _dragPosition = 0.0;
  double _dragPercentage = 0.0;
  bool _isButtonAsInitialState = true;
  int _colorValue = 0;

  // Color initialToChangeColor = widget.changeColor;
  // Color changerToInitialColor = widget.initialColor;

  void _updateDragPosition(Offset val) {
    double newDragPosition = 0.0;
    if (val.dx <= 0.0) {
      newDragPosition = 0.0;
      _isButtonAsInitialState = true;
    } else if (val.dx >= widget.sliderWidth - widget.thumbWidth) {
      newDragPosition = widget.sliderWidth - widget.thumbWidth;
      _isButtonAsInitialState = false;
    } else {
      newDragPosition = val.dx;
      // print('position Value:${0.0/newDragPosition}');
    }

    setState(() {
      _dragPosition = newDragPosition;
      _dragPercentage = _dragPosition / widget.sliderWidth;
      print('position Value:$_dragPercentage');
      _colorValue = _dragPercentage.round();
      print('Color Value:$_colorValue');
    });
  }

  void _onDragStart(BuildContext context, DragStartDetails start) {
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.globalToLocal(start.globalPosition);
    _updateDragPosition(localOffset);
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.globalToLocal(update.globalPosition);
    //print(update.globalPosition);
    _updateDragPosition(localOffset);
  }

  void _onDragEnd(BuildContext context, DragEndDetails end) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          print('Taped');
          _isButtonAsInitialState ? widget.onTapFun(true): widget.onTapFun(false);
        },
        onLongPress: () {
          print('On long Pressed');
          //_isButtonAsInitialState ? true: false;
        },
        onDoubleTap: () {
          print('On Double Tapped');
          // _isButtonAsInitialState ? true: false;
        },
        child: Card(
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(widget.cornerRadius), // if you need this
            side: BorderSide(
              color: widget.borderColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.color.withOpacity(_dragPercentage),
              // _buttonInitialState
              // ? widget.initialColor.withOpacity(_dragPercentage)
              // : widget.changeColor.withOpacity(_dragPercentage),
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              border: Border.all(
                color: widget.borderColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Container(
                width: widget.sliderWidth,
                height: widget.sliderHeight,
                //color: Colors.grey,

                child: Container(
                  child: CustomPaint(
                    painter: ThumbCustomPainter(
                      color: widget.thumbColor,
                      dragPercentage: _dragPercentage,
                      sliderPosition: _dragPosition,
                      thumbHeight: widget.thumbHeight,
                      thumbWidth: widget.thumbWidth,
                      thumbRadius: 8.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          _isButtonAsInitialState
                              ? widget.initialLevelText
                              : widget.changeLevelText,
                          style: TextStyle(
                            color: _isButtonAsInitialState
                                ? widget.initialTextColor
                                : widget.changeTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onHorizontalDragStart: (DragStartDetails start) =>
          _onDragStart(context, start),
      onHorizontalDragUpdate: (DragUpdateDetails update) =>
          _onDragUpdate(context, update),
      onHorizontalDragEnd: (DragEndDetails end) => _onDragEnd(context, end),
    );
  }
}
