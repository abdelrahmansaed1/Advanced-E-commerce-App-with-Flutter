import 'package:e_commerce_project/features/onboarding/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingModel model;
  const OnboardingContent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(model.title, style: AppTextStyles.displayLarge),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(model.subtitle, style: AppTextStyles.titleMedium),
          ),
        ],
      ),
    );
  }
}
