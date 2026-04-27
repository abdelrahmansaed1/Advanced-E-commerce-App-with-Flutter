import 'package:e_commerce_project/features/onboarding/model/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingModel model;
  const OnboardingContent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              model.title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              model.subtitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
