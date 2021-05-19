import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThumbCustomPainter extends CustomPainter {
  final double sliderPosition;
  final double dragPercentage;
  final Color color;
  final double thumbHeight;
  final double thumbWidth;
  final Paint fillPainter;
  final double thumbRadius;

  ThumbCustomPainter({
    @required this.sliderPosition,
    @required this.dragPercentage,
    @required this.color,
    @required this.thumbHeight,
    @required this.thumbWidth,
    this.thumbRadius = 8.0,
  }) : fillPainter = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    _paintBlock(canvas, size);
  }

  _paintBlock(Canvas canvas, Size size) {
    Rect sliderRect = Offset(sliderPosition, (size.height - thumbHeight) / 2) &
        Size(thumbWidth, thumbHeight);

    RRect ss = RRect.fromRectAndCorners(
      sliderRect,
      bottomLeft: Radius.circular(thumbRadius),
      bottomRight: Radius.circular(thumbRadius),
      topLeft: Radius.circular(thumbRadius),
      topRight: Radius.circular(thumbRadius),
    );
    canvas.drawRRect(ss, fillPainter);

    //canvas.drawRect(sliderRect, fillPainter);
    //print('Slider Position: $sliderPosition');
    //print('Height: ${size.height}');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
