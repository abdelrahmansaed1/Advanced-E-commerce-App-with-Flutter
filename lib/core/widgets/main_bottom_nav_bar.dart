import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:e_commerce_project/core/providers/navigation_provider.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainBottomNavBar extends StatelessWidget {
  final Function(int) onTapChanged;
  MainBottomNavBar({super.key, required this.onTapChanged});

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
    final currentIndex = context.watch<NavigationProvider>().index;
    return Container(
      color: Colors.transparent,
      child: Container(
        height: AppSizes.kMainBottomNavBarHeigth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryColor, Colors.black],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _icons.length,
            (index) => _navItem(
              context: context,
              currentIndex: currentIndex,
              index: index,
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem({
    required BuildContext context,
    required int index,
    required int currentIndex,
  }) {
    final isSelected = currentIndex == index;

    final currentColor = isSelected ? _selectedColor : _unselectedColor;

    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(30.r)),
      // behavior: HitTestBehavior.opaque,
      onTap: () {
        context.read<NavigationProvider>().setIndex(index);
        onTapChanged(index);
      },
      child: SizedBox(
        width: 70.w,
        height: 70.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,

                transform: Matrix4.translationValues(
                  0,
                  // this is for small devices, to prevent the icon from going out of the container
                  // isSelected ? -12.6.h : -12.6.h,
                  isSelected ? -18.5.h : -18.5.h,
                  0,
                ),

                width: isSelected ? 70.w : 24.w,
                height: isSelected ? 70.h : 24.h,

                decoration: BoxDecoration(shape: BoxShape.circle),

                child: isSelected
                    ? Center(
                        child: Stack(
                          // alignment: Alignment.center,
                          children: [
                            AppImages.activeSvg(),
                            Positioned(
                              top: 12.h,
                              bottom: 9.h,
                              left: 12.w,
                              right: 12.w,
                              child: SvgPicture.asset(
                                _icons[index],
                                width: isSelected ? 28.w : 24.w,
                                height: isSelected ? 28.h : 24.h,
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
                        width: 24.w,
                        height: 24.h,
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
    );
  }
}
