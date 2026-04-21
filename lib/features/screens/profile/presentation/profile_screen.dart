import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/widgets/app_list_item.dart';
import 'package:e_commerce_project/core/widgets/custom_popup.dart';
import 'package:e_commerce_project/features/screens/profile/presentation/widgets/signout_popup.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppImages.personal,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Abdelrahman Saed",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'abdelrahmansaeds321@gmail.com',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.editProfile);
                    },
                    child: AppImages.editSvg(width: 16, height: 16),
                  ),
                ],
              ),
            ),
            AppListItem(
              icon: AppImages.serverSvg(),
              title: 'My orders',
              showArrow: true,
            ),
            SizedBox(height: 16),
            AppListItem(
              icon: AppImages.creditCardSvg(width: 16, height: 16),
              title: 'Payment method',
              showArrow: true,
            ),
            SizedBox(height: 16),
            AppListItem(
              icon: AppImages.mapPinSvg(width: 16, height: 16),
              title: 'Delivery address',
              showArrow: true,
            ),
            SizedBox(height: 16),
            AppListItem(
              icon: AppImages.giftSvg(width: 16, height: 16),
              title: 'Promocodes & gift cards',
              showArrow: true,
            ),
            SizedBox(height: 16),
            // AppListItem(
            //   icon: AppImages.logoutSvg(width: 16, height: 16),
            //   title: 'Sign out',
            //   onTap: () => SignoutPopup(),
            // ),
            AppListItem(
              icon: AppImages.logoutSvg(width: 16, height: 16),
              title: 'Sign out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const SignoutPopup(),
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
