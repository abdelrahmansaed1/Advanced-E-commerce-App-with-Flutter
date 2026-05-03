import 'dart:async';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final prefs = Provider.of<AppPreferences>(context, listen: false);
    final isFirst = !prefs.isOnboardingCompleted();
    final isLoggedIn = prefs.isAuthenticated();

    if (isLoggedIn) {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).refreshTokenIfNeeded();
    }

    if (!mounted) return;

    if (isFirst) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    } else if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.screens);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.signin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 80.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppImages.logoSvg(),
                SizedBox(height: 20.h),
                Text('kastelli', style: AppTextStyles.displayMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
