import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/video_widget.dart';

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
        final String? mediaUrl = index < images.length ? images[index] : null;

        return Container(
          height: height,
          padding: EdgeInsets.only(right: padding ?? 0, bottom: padding ?? 0),
          child: Stack(
            // fit: StackFit.expand,
            children: [
              // Background
              _buildMedia(mediaUrl),

              // Content
              Positioned(
                top: topForText,
                bottom: topForText != null ? null : 150,
                left: 20,
                child: padding == null
                    ? const SizedBox()
                    : Text(
                        title,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
              ),

              Positioned(
                top: topForButton,
                bottom: topForButton != null ? null : 70,
                left: 20,
                child: padding == null
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1.5,
                              color: AppTheme.primaryColor,
                            ),
                            bottom: BorderSide(
                              width: 1.5,
                              color: AppTheme.primaryColor,
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
