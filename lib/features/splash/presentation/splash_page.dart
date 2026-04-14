import 'dart:async';

import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/features/onboarding/presentation/onboarding_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goToOnBoardingPage();
  }

  void _goToOnBoardingPage() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Image.asset('assets/images/logo.png'),
                AppImages.logoSvg(),
                SizedBox(height: 20),
                Text(
                  'kastelli',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
