import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:e_commerce_project/features/home/presentation/widgets/home_banner.dart';
import 'package:e_commerce_project/features/home/presentation/widgets/home_list_view.dart';
import 'package:e_commerce_project/features/home/presentation/widgets/home_text_section.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Available height for full banners (Screen - AppBar - BottomNav)
    final double availableBannerHeight =
        MediaQuery.of(context).size.height -
        (Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight) -
        AppSizes.kMainBottomNavBarHeigth;

    // Sample Data - Easy to replace with real data later
    final List<String> mainCarouselImages = [
      "assets/images/one.jpg",
      "assets/images/two.jpg",
      "assets/images/three.jpg",
      "assets/images/four.jpg",
    ];

    final List<String> bannerImages = ["assets/images/two.jpg"];

    final List<ProductsModel> bestSellersItems = [
      ProductsModel(
        title: "Warm winter hat",
        price: 12.7,
        oldPrice: null,
        hasSale: false,
        image: 'assets/images/one.jpg',
        isAdded: false,
      ),
      ProductsModel(
        title: "Short summer dress",
        price: 129.0,
        oldPrice: 150.0,
        hasSale: true,
        image: '', // You can put a real path later
        isAdded: false,
      ),
      ProductsModel(
        title: "Leather handbag",
        price: 89.99,
        oldPrice: null,
        hasSale: false,
        image: '',
        isAdded: false,
      ),
      ProductsModel(
        title: "Modern suit",
        price: 45.5,
        oldPrice: 59.0,
        hasSale: true,
        image: '',
        isAdded: false,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ==================== MAIn CAROUSEL FULL-HEIGHT BANNERS ====================
          HomeBanner(
            height: availableBannerHeight,
            title: 'Black Friday sale! \nSave up to 25%',
            count: mainCarouselImages.length,
            images: mainCarouselImages,
          ),

          // ==================== BEST SELLERS SECTION ====================
          SliverToBoxAdapter(child: HomeTextSection(title: 'Best Sellers')),

          // Best Sellers
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: HomeListView(items: bestSellersItems),
            ),
          ),

          // Extra space at bottom
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ==================== MAIn CAROUSEL FULL-HEIGHT BANNERS ====================
          HomeBanner(
            height: 200,
            padding: 20,
            topForText: 30,
            topForButton: 112,
            title: 'Spring Discounts \nUp To 30% Off',
            count: bannerImages.length,
            images: bannerImages,
          ),

          // ==================== Featured products SECTION ====================
          SliverToBoxAdapter(
            child: HomeTextSection(title: 'Featured Products'),
          ),

          // Best Sellers
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: HomeListView(items: bestSellersItems),
            ),
          ),
        ],
      ),
    );
  }
}
