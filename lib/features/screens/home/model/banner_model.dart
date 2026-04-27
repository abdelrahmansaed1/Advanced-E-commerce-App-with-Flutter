import 'package:e_commerce_project/features/screens/home/model/banner_image_model.dart';

class BannerModel {
  final String title;
  final String mainCategory;
  final String type;
  final String? categoryId;
  final String? url;
  final List<BannerImageModel> images;

  BannerModel({
    required this.title,
    required this.mainCategory,
    required this.type,
    this.categoryId,
    this.url,
    required this.images,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    title: json['title'] ?? '',
    mainCategory: json['main_category'] ?? '',
    type: json['type'] ?? '',
    categoryId: json['category_id']?.toString(),
    url: json['url'],
    images: (json['images'] as List? ?? [])
        .map((e) => BannerImageModel.fromJson(e))
        .toList(),
  );
}
