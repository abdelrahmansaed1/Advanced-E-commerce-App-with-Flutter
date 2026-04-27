class BannerImageModel {
  final String id;
  final String image;
  final String? title;
  final String? categoryId;
  final String? url;

  BannerImageModel({
    required this.id,
    required this.image,
    this.title,
    this.categoryId,
    this.url,
  });

  factory BannerImageModel.fromJson(Map<String, dynamic> json) {
    return BannerImageModel(
      id: json['id']?.toString() ?? '',
      image: json['image'] ?? '',
      title: json['title'],
      categoryId: json['category_id']?.toString(),
      url: json['url'],
    );
  }
}
