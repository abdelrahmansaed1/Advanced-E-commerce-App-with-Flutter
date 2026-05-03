import 'package:e_commerce_project/core/theme/app_text_styles.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppListItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback? onTap;
  final bool showArrow;
  final int badgeCount;

  const AppListItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.showArrow = false,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: EdgeInsets.only(left: 16.w, top: 6.h, bottom: 6.h, right: 0),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide.none,
          top: BorderSide(width: 1, color: AppTheme.borderColor),
          bottom: BorderSide(width: 1, color: AppTheme.borderColor),
          left: BorderSide(width: 1, color: AppTheme.borderColor),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          bottomLeft: Radius.circular(8.r),
          topRight: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: AppTextStyles.bodyLarge)),
          if (badgeCount > 0)
            Container(
              width: 22.w,
              height: 22.h,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$badgeCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (showArrow)
            Icon(Icons.chevron_right, color: AppTheme.primaryColor, size: 20.w),
        ],
      ),
    );

    return InkWell(onTap: onTap, child: content);
  }
}
