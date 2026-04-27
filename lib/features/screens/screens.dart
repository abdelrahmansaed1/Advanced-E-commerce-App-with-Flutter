import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/core/widgets/main_app_drawer.dart';
import 'package:e_commerce_project/core/widgets/main_bottom_nav_bar.dart';
import 'package:e_commerce_project/features/screens/wishlist/presentation/wish_list_screen.dart';
import 'package:e_commerce_project/features/screens/cart/presentation/cart_screen.dart';
import 'package:e_commerce_project/features/screens/home/presentation/home_screen.dart';
import 'package:e_commerce_project/features/screens/profile/presentation/profile_screen.dart';
import 'package:e_commerce_project/features/screens/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const CartPage(),
    const WishListPage(),
    const ProfileScreen(),
  ];

  final List<PreferredSizeWidget?> _appBars = [
    const MainAppBar(), // index 0
    const MainAppBar(isSearchBar: true), // index 1
    const MainAppBar(title: "Order"), // index 2
    const MainAppBar(title: "Wishlist"), // index 3
    const MainAppBar(title: "My Profile"), // index 4
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppTheme.backgroundColor,
        appBar: _appBars[_selectedIndex],
        drawer: const MainAppDrawer(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: MainBottomNavBar(
          onTapChanged: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
