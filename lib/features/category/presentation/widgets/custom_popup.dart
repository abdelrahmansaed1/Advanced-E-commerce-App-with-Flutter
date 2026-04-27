import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final Widget content;
  final double? width;

  const CustomPopup({super.key, required this.content, this.width});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 1,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: width ?? 340,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [content],
          ),
        ),
      ),
    );
  }
}
