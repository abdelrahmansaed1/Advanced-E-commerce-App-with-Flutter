import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../constants/app_images.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isSearchBar;
  final String? title;
  final bool showBackButton;
  const MainAppBar({
    super.key,
    this.title,
    this.isSearchBar = false,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leadingWidth: 40,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pop(context),
              color: AppTheme.primaryColor,
            )
          : IconButton(
              padding: const EdgeInsets.only(left: 16.0),
              icon: AppImages.burgerSvg(),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      title: titleMethod(context),
      centerTitle: true,
      actions: [CountsWidget(), CartIcon()],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(),
      ),
    );
  }

  Widget titleMethod(BuildContext context) {
    return isSearchBar == true
        ? TextField(
            decoration: InputDecoration(
              icon: AppImages.searchSvg(
                color: AppTheme.secondaryColor,
                width: 14,
                height: 14,
              ),
              contentPadding: const EdgeInsets.all(0),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        : Text(title ?? '', style: Theme.of(context).textTheme.headlineSmall);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 5),
      child: GestureDetector(onTap: () {}, child: AppImages.shoppingCartSvg()),
    );
  }
}

class CountsWidget extends StatelessWidget {
  const CountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.primaryColor,
      ),
      child: Text(
        '12',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class LeadingBuilder extends StatelessWidget {
  const LeadingBuilder({super.key, required this.icon});

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: icon != null
              // ? Icon(icon, color: AppTheme.primaryColor)
              ? null
              : AppImages.burgerSvg(),
        ),
      ),
    );
  }
}
