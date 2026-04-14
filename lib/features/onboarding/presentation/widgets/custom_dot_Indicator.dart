import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_project/core/constants/app_colors.dart';
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
        size: Size.square(12),
        activeSize: Size.square(12),
        activeColor: AppColors.primaryColor,
        color: Color(0xffDEE1E4),
      ),
    );
  }
}
