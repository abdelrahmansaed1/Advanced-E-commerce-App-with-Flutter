import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/core/widgets/main_app_drawer.dart';
import 'package:e_commerce_project/core/widgets/main_bottom_nav_bar.dart';
import 'package:e_commerce_project/features/Favorite/presentation/favorites_page.dart';
import 'package:e_commerce_project/features/cart/presentation/cart_page.dart';
import 'package:e_commerce_project/features/home/presentation/home_page.dart';
import 'package:e_commerce_project/features/profile/presentation/profile_page.dart';
import 'package:e_commerce_project/features/search/presentation/search_page.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    const SearchPage(),
    const CartPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: MainAppBar(),
      drawer: const MainAppDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MainBottomNavBar(
        onTapChanged: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
