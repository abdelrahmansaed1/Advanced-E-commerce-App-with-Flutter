import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class MainBottomNavBar extends StatefulWidget {
  final Function(int) onTapChanged;
  const MainBottomNavBar({super.key, required this.onTapChanged});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.search,
    Icons.shopping_cart_outlined,
    Icons.favorite_border,
    Icons.account_circle_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.kMainBottomNavBarHeigth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, Colors.black],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _icons.length,
          (index) => _navItem(index: index),
        ),
      ),
    );
  }

  Widget _navItem({required int index}) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
        widget.onTapChanged(index);
      },
      child: SizedBox(
        width: 70,
        height: 70,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,

              transform: Matrix4.translationValues(
                0,
                isSelected ? -16 : -16,
                0,
              ),

              width: isSelected ? 70 : 40,
              height: isSelected ? 70 : 40,

              decoration: BoxDecoration(shape: BoxShape.circle),

              child: isSelected
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        AppImages.activeSvg(),
                        Icon(
                          _icons[index],
                          size: 30,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    )
                  : Icon(
                      _icons[index],
                      size: 30,
                      color: AppColors.backgroundColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
