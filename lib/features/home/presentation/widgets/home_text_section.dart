import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomeTextSection extends StatelessWidget {
  final String title;
  const HomeTextSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          Row(
            children: [
              Text("view all", style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(width: 6),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
