import 'package:e_commerce_project/core/providers/navigation_provider.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants/app_images.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? isSearchBar;
  final String? title;
  final bool showBackButton;
  final VoidCallback? goToCart;
  const MainAppBar({
    super.key,
    this.title,
    this.isSearchBar = false,
    this.showBackButton = false,
    this.goToCart,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leadingWidth: 40.w,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pop(context),
              color: AppTheme.primaryColor,
            )
          : IconButton(
              padding: EdgeInsets.only(left: 16.w),
              icon: AppImages.burgerSvg(),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
      title: titleMethod(context),
      centerTitle: true,
      actions: [ShoppingCart()],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
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
                width: 14.w,
                height: 14.h,
              ),
              contentPadding: EdgeInsets.all(0.w),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: AppTextStyles.bodyMedium,
            ),
          )
        : Text(title ?? '', style: AppTextStyles.headlineSmall);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1.h);
}

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<NavigationProvider>().goToCart(context);
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [CountsWidget(), CartIcon()],
        ),
      ),
    );
  }
}

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, left: 5.w),
      child: AppImages.shoppingCartSvg(),
    );
  }
}

class CountsWidget extends StatelessWidget {
  const CountsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<CartProvider>().itemCount;
    return Container(
      width: 30.w,
      padding: EdgeInsets.all(8.w),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.primaryColor,
      ),
      child: Center(
        child: Text(
          '$count',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
