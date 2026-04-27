import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_list_item.dart';
import 'package:e_commerce_project/features/category/Provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppDrawer extends StatelessWidget {
  const MainAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();
    return Drawer(
      child: Column(
        children: [
          DrawerHeaderWidget(),
          drawerItem(title: 'Categories', context: context),
          drawerItem(
            title: 'Sales',
            context: context,
            route: AppRoutes.category,
            args: {'title': 'Sales', 'products': productsProvider.onSale},
          ),
          drawerItem(
            title: 'New Arrivals',
            context: context,
            route: AppRoutes.category,
            args: {
              'title': 'New Arrivals',
              'products': productsProvider.newArrivals,
            },
          ),
          drawerItem(
            title: 'Best Sellers',
            context: context,
            route: AppRoutes.category,
            args: {
              'title': 'Best Sellers',
              'products': productsProvider.bestSellers,
            },
          ),
          drawerItem(
            title: 'Featured products',
            context: context,
            route: AppRoutes.category,
            args: {
              'title': 'Featured products',
              'products': productsProvider.featured,
            },
          ),
          SizedBox(height: 20),

          AppListItem(
            icon: AppImages.bellSvg(),
            title: 'Notfications',
            badgeCount: 1,
          ),
          AppListItem(icon: AppImages.helpCircleSvg(), title: 'Support'),
        ],
      ),
    );
  }

  GestureDetector drawerItem({
    required String title,
    required BuildContext context,
    String? route,
    Map<String, dynamic>? args,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (route != null) {
          Navigator.pushNamed(context, route, arguments: args);
        }
      },
      child: ListTile(
        leading: Icon(Icons.chevron_right, color: AppTheme.primaryColor),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: AppTheme.backgroundColor),
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
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
