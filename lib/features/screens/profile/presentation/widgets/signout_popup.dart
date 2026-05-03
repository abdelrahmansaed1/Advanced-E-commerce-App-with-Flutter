import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignoutPopup extends StatelessWidget {
  final double? width;

  const SignoutPopup({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 1,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        width: width ?? 340.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor),
                  shape: BoxShape.circle,
                ),
                child: AppImages.logoutSvg(width: 24.w, height: 24.h),
              ),
              SizedBox(height: 20.h),
              Text(
                'Are You Sure You Want To Sign Out ?',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(letterSpacing: 0),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: AppElevatedButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: AppElevatedButton(
                      text: 'sure',
                      onPressed: () async {
                        final navigator = Navigator.of(
                          context,
                          rootNavigator: true,
                        );
                        Navigator.pop(context);
                        await Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        ).logout(navigator);
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
