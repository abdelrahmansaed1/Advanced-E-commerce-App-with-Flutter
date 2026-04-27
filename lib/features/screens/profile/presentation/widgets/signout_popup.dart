import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/services/app_preferences.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignoutPopup extends StatelessWidget {
  final double? width;

  const SignoutPopup({super.key, this.width});

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
            children: [
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor),
                  shape: BoxShape.circle,
                ),
                child: AppImages.logoutSvg(width: 24, height: 24),
              ),
              const SizedBox(height: 20),
              Text(
                'Are You Sure You Want To Sign Out ?',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(letterSpacing: 0),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppElevatedButton(
                      text: 'sure',
                      onPressed: () async {
                        final prefs = Provider.of<AppPreferences>(
                          context,
                          listen: false,
                        );
                        await prefs.logout();
                        if (!context.mounted) return;
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.signin,
                        );
                      },
                      color: AppTheme.secondaryBackgroundColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
