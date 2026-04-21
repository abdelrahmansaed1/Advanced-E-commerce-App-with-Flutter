import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(left: 16, top: 6, bottom: 6, right: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide.none,
          top: BorderSide(width: 1, color: AppTheme.borderColor),
          bottom: BorderSide(width: 1, color: AppTheme.borderColor),
          left: BorderSide(width: 1, color: AppTheme.borderColor),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          topRight: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),
          if (badgeCount > 0)
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$badgeCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (showArrow)
            Icon(Icons.chevron_right, color: AppTheme.primaryColor, size: 20),
        ],
      ),
    );

    return InkWell(onTap: onTap, child: content);
  }
}
