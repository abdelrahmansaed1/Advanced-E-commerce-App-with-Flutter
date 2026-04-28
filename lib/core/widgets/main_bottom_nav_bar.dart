import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainBottomNavBar extends StatefulWidget {
  final Function(int) onTapChanged;
  const MainBottomNavBar({super.key, required this.onTapChanged});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;
  final Color _selectedColor = AppTheme.primaryColor;
  final Color _unselectedColor = AppTheme.backgroundColor;

  final List<String> _icons = [
    AppImages.home,
    AppImages.search,
    AppImages.bottomShoppingCart,
    AppImages.heart,
    AppImages.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: AppSizes.kMainBottomNavBarHeigth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryColor, Colors.black],
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
      ),
    );
  }

  Widget _navItem({required int index}) {
    final isSelected = _selectedIndex == index;

    final currentColor = isSelected ? _selectedColor : _unselectedColor;

    return Container(
      // padding: const EdgeInsets.all(12),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        // behavior: HitTestBehavior.opaque,
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
              Positioned(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,

                  transform: Matrix4.translationValues(
                    0,
                    isSelected ? -16 : -16,
                    0,
                  ),

                  width: isSelected ? 70 : 24,
                  height: isSelected ? 70 : 24,

                  decoration: BoxDecoration(shape: BoxShape.circle),

                  child: isSelected
                      ? Center(
                          child: Stack(
                            // alignment: Alignment.center,
                            children: [
                              AppImages.activeSvg(),
                              Positioned(
                                top: 12,
                                bottom: 9,
                                left: 12,
                                right: 12,
                                child: SvgPicture.asset(
                                  _icons[index],
                                  width: isSelected ? 28 : 24,
                                  height: isSelected ? 28 : 24,
                                  alignment: AlignmentGeometry.center,
                                  colorFilter: ColorFilter.mode(
                                    currentColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SvgPicture.asset(
                          _icons[index],
                          width: isSelected ? 24 : 24,
                          height: isSelected ? 24 : 24,
                          alignment: AlignmentGeometry.center,
                          colorFilter: ColorFilter.mode(
                            currentColor,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
