import 'package:e_commerce_project/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  final double height;
  final String title;
  final int count;
  final List<String> images;
  final double? padding;
  final double? topForText;
  final double? topForButton;

  const HomeBanner({
    super.key,
    required this.height,
    required this.title,
    required this.count,
    required this.images,
    this.padding,
    this.topForText,
    this.topForButton,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          height: height,
          padding: EdgeInsets.only(right: padding ?? 0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                color: const Color(0xffECF3FA),
                // child: Image.asset(images[index], fit: BoxFit.cover),
              ),

              // Content
              Positioned(
                top: topForText,
                bottom: topForText != null ? null : 150,
                left: 20,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),

              Positioned(
                top: topForButton,
                bottom: topForButton != null ? null : 70,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.5,
                        color: AppColors.primaryColor,
                      ),
                      bottom: BorderSide(
                        width: 1.5,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  child: Text(
                    "SHOP NOW".toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ],
          ),
        );
      }, childCount: count),
    );
  }
}
