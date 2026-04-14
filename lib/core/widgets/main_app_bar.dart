import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../constants/app_images.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const MainAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 40,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: AppImages.burgerSvg(),
          ),
        ),
      ),
      title: Text(title ?? ''),
      centerTitle: true,
      elevation: 0,
      actions: [
        Container(
          width: 30,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          child: Text(
            '12',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 5),
          child: GestureDetector(
            onTap: () {},
            child: AppImages.shoppingCartSvg(),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
