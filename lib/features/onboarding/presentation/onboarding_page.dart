import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:e_commerce_project/features/onboarding/presentation/widgets/custom_dot_indicator.dart';
import 'package:e_commerce_project/models/onboarding_model.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  double currentPage = 0;
  final List<OnboardingModel> data = [
    OnboardingModel(
      title: 'Welcome to Kastelli!',
      subtitle: 'Labore sunt culpa excepteur culpa occaecat ex nisi mollit.',
    ),
    OnboardingModel(
      title: 'Easy Track your Order!',
      subtitle: 'Labore sunt culpa excepteur culpa occaecat ex nisi mollit.',
    ),
    OnboardingModel(
      title: 'Door to Door Delivery!',
      subtitle: 'Labore sunt culpa excepteur culpa occaecat ex nisi mollit.',
    ),
  ];
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        currentPage = _controller.page ?? 0;
      });
    });
  }

  void nextPage() {
    Navigator.pushReplacementNamed(context, AppRoutes.signin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 120),
          // PageView
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return OnboardingContent(model: data[index]);
              },
            ),
          ),

          // Dots
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: CustomDotIndicator(
              length: data.length,
              currentPage: currentPage,
            ),
          ),
          Spacer(flex: 2),

          // Elevated Button
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppElevatedButton(
                text: "Get Started",
                onPressed: nextPage,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
