import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  final int length;
  final double currentPage;
  const CustomDotIndicator({
    super.key,
    required this.length,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: length,
      position: currentPage,
      decorator: DotsDecorator(
        size: Size.square(10),
        activeSize: Size.square(10),
        activeColor: AppTheme.primaryColor,
        color: AppTheme.backgroundColor,
      ),
    );
  }
}
