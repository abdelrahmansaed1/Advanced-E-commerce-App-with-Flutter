import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:e_commerce_project/core/data/dummy_data.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/home_banner.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/home_list_view.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/home_text_section.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          SliverToBoxAdapter(
            child: HomeTextSection(
              title: 'Best Sellers',
              route: AppRoutes.category,
              args: {
                'title': 'Best Sellers',
                'products': DummyData.bestSellers,
              },
            ),
          ),

          // Best Sellers
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: HomeListView(items: DummyData.bestSellers),
            ),
          ),

          // Extra space at bottom
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ==================== MAIn CAROUSEL FULL-HEIGHT BANNERS ====================
          HomeBanner(
            height: 200,
            padding: 16,
            topForText: 30,
            topForButton: 112,
            title: 'Spring Discounts \nUp To 30% Off',
            count: bannerImages.length,
            images: bannerImages,
          ),

          // ==================== Featured products SECTION ====================
          SliverToBoxAdapter(
            child: HomeTextSection(
              title: 'Featured Products',
              route: AppRoutes.category,
              args: {
                'title': 'Featured Products',
                'products': DummyData.bestSellers,
              },
            ),
          ),

          // Featured Products
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: HomeListView(items: DummyData.featuredProducts),
            ),
          ),
        ],
      ),
    );
  }
}
