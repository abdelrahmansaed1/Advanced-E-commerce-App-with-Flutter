import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

class HomeTextSection extends StatelessWidget {
  final String title;
  final String route;
  final Map<String, dynamic> args;
  const HomeTextSection({
    super.key,
    required this.title,
    required this.route,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.headlineMedium),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, route, arguments: args);
            },
            child: Row(
              children: [
                Text("view all", style: AppTextStyles.bodyLarge),
                SizedBox(width: 6),
                Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
