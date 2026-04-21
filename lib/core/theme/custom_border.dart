import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBorder extends InputBorder {
  final Color color;
  final double width;

  const CustomBorder({this.color = AppTheme.borderColor, this.width = 1.5})
    : super(borderSide: BorderSide.none);

  @override
  InputBorder copyWith({BorderSide? borderSide}) =>
      CustomBorder(color: color, width: width);

  @override
  bool get isOutline => true;

  @override
  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    if (gapStart == null || gapPercentage == 0.0) {
      // no gap — draw full top line
      canvas.drawLine(rect.topLeft, rect.topRight, paint);
    } else {
      final double gapPadding = 8.0;
      final double gapBegin = gapStart - gapPadding;
      final double gapEnd = gapStart + gapExtent * gapPercentage + gapPadding;

      // left segment of top line
      canvas.drawLine(
        rect.topLeft,
        Offset(rect.left + gapBegin, rect.top),
        paint,
      );
      // right segment of top line (after the label)
      canvas.drawLine(
        Offset(rect.left + gapEnd, rect.top),
        rect.topRight,
        paint,
      );
    }

    // bottom line — always full
    canvas.drawLine(rect.bottomLeft, rect.bottomRight, paint);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Path()..addRect(rect);

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }
}
