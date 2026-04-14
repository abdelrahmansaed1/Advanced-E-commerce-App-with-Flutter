import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/widgets/global_list_item.dart';
import 'package:flutter/material.dart';

class MainAppDrawer extends StatelessWidget {
  const MainAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.backgroundColor),
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
                    Text(
                      'abdelrahmansaeds321@gmail.com',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          itemBuilder(title: 'Categories', context: context),
          itemBuilder(title: 'Sales', context: context),
          itemBuilder(title: 'New Arrivals', context: context),
          itemBuilder(title: 'Best Sellers', context: context),
          itemBuilder(title: 'Featured products', context: context),
          SizedBox(height: 20),

          GlobalListItem(
            icon: AppImages.bellSvg(),
            title: 'Notfications',
            badgeCount: 1,
          ),
          GlobalListItem(icon: AppImages.helpCircleSvg(), title: 'Support'),
        ],
      ),
    );
  }

  ListTile itemBuilder({required String title, required BuildContext context}) {
    return ListTile(
      leading: Icon(Icons.chevron_right, color: AppColors.primaryColor),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      onTap: () {},
    );
  }
}
