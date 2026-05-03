import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/video_widget.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        final String? mediaUrl = index < images.length ? images[index] : null;

        return Container(
          height: height,
          padding: EdgeInsets.only(
            right: padding?.w ?? 0,
            bottom: padding?.h ?? 0,
          ),
          child: Stack(
            // fit: StackFit.expand,
            children: [
              // Background
              _buildMedia(mediaUrl),

              // Content
              Positioned(
                top: topForText?.h,
                bottom: topForText != null ? null : 150.h,
                left: 20.w,
                child: padding == null
                    ? const SizedBox()
                    : Text(title, style: AppTextStyles.displayLarge),
              ),

              Positioned(
                top: topForButton?.h,
                bottom: topForButton != null ? null : 70.h,
                left: 20.w,
                child: padding == null
                    ? const SizedBox()
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1.5.w,
                              color: AppTheme.primaryColor,
                            ),
                            bottom: BorderSide(
                              width: 1.5.w,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                        child: Text(
                          "SHOP NOW".toUpperCase(),
                          style: AppTextStyles.labelSmall,
                        ),
                      ),
              ),
            ],
          ),
        );
      }, childCount: count),
    );
  }

  // ================= MEDIA BUILDER =================
  Widget _buildMedia(String? url) {
    // ===== Fallback (no media) =====
    if (url == null || url.isEmpty) {
      return Container(color: const Color(0xffECF3FA));
    }

    // ===== VIDEO =====
    if (url.toLowerCase().endsWith('.mp4')) {
      return SmartVideoWidget(url: url);
    }

    // ===== IMAGE =====
    return url.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, child) {
              return Container(color: const Color(0xffECF3FA));
            },
            errorWidget: (context, error, stackTrace) {
              return Container(color: const Color(0xffECF3FA));
            },
          )
        : Container(color: const Color(0xffECF3FA));
  }
}
