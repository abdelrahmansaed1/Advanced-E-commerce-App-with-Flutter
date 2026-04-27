import 'package:e_commerce_project/features/screens/home/model/banner_model.dart';

class HomeModel {
  final String title;
  final List<BannerModel> topBanner;
  final List<BannerModel> footerBanner;

  HomeModel({
    required this.title,
    required this.topBanner,
    required this.footerBanner,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final banners = json['banners'] as Map<String, dynamic>? ?? {};

    return HomeModel(
      title: json['title'],
      topBanner: (banners['top_banner'] as List? ?? [])
          .map((e) => BannerModel.fromJson(e))
          .toList(),
      footerBanner: (banners['footer_banner'] as List? ?? [])
          .map((e) => BannerModel.fromJson(e))
          .toList(),
    );
  }
}
