import 'package:e_commerce_project/core/providers/navigation_provider.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/core/widgets/main_app_drawer.dart';
import 'package:e_commerce_project/core/widgets/main_bottom_nav_bar.dart';
import 'package:e_commerce_project/features/screens/cart/presentation/cart_screen.dart';
import 'package:e_commerce_project/features/screens/home/presentation/home_screen.dart';
import 'package:e_commerce_project/features/screens/profile/presentation/profile_screen.dart';
import 'package:e_commerce_project/features/screens/search/presentation/search_screen.dart';
import 'package:e_commerce_project/features/screens/wishlist/presentation/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Screens extends StatelessWidget {
  const Screens({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

    final pages = [
      const HomeScreen(),
      const SearchScreen(),
      const CartPage(),
      const WishListPage(),
      const ProfileScreen(),
    ];

    final appBars = [
      const MainAppBar(),
      const MainAppBar(isSearchBar: true),
      const MainAppBar(title: "Order"),
      const MainAppBar(title: "Wishlist"),
      const MainAppBar(title: "My Profile"),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: appBars[nav.index],
      body: IndexedStack(index: nav.index, children: pages),
      // body: pages[nav.index],
      drawer: const MainAppDrawer(),
      bottomNavigationBar: MainBottomNavBar(
        onTapChanged: (i) => context.read<NavigationProvider>().setIndex(i),
      ),
    );
  }
}
