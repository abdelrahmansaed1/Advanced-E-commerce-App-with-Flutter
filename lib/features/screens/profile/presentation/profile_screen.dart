import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/widgets/app_list_item.dart';
import 'package:e_commerce_project/features/screens/profile/presentation/widgets/signout_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppImages.personal,
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Abdelrahman Saed",
                        style: AppTextStyles.labelMedium,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'abdelrahmansaeds321@gmail.com',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.editProfile);
                    },
                    child: AppImages.editSvg(width: 16.w, height: 16.h),
                  ),
                ],
              ),
            ),
            AppListItem(
              icon: AppImages.serverSvg(),
              title: 'My orders',
              showArrow: true,
            ),
            SizedBox(height: 16.h),
            AppListItem(
              icon: AppImages.creditCardSvg(width: 16.w, height: 16.h),
              title: 'Payment method',
              showArrow: true,
            ),
            SizedBox(height: 16.h),
            AppListItem(
              icon: AppImages.mapPinSvg(width: 16.w, height: 16.h),
              title: 'Delivery address',
              showArrow: true,
            ),
            SizedBox(height: 16.h),
            AppListItem(
              icon: AppImages.giftSvg(width: 16.w, height: 16.h),
              title: 'Promocodes & gift cards',
              showArrow: true,
            ),
            SizedBox(height: 16.h),

            AppListItem(
              icon: AppImages.logoutSvg(width: 16.w, height: 16.h),
              title: 'Sign out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const SignoutPopup(),
                );
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
