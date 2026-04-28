import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:e_commerce_project/features/category/Provider/products_provider.dart';
import 'package:e_commerce_project/features/relatedproducts/presentation/related_products_section.dart';
import 'package:e_commerce_project/features/screens/home/provider/home_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/home_banner.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/home_list_view.dart';
import 'package:e_commerce_project/features/screens/home/presentation/widgets/home_text_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final productsProvider = context.watch<ProductsProvider>();
    // Loading state
    if (homeProvider.state == HomeState.loading) {
      return Center(child: CircularProgressIndicator());
    }

    // Error state
    if (homeProvider.state == HomeState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(homeProvider.errorMessage ?? 'Something went wrong'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => homeProvider.loadDashboard(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final home = homeProvider.homeData;
    if (home == null) return const SizedBox();

    // Available height for full banners (Screen - AppBar - BottomNav)
    // final double availableBannerHeight =
    //     MediaQuery.of(context).size.height -
    //     (Scaffold.of(context).appBarMaxHeight ?? kToolbarHeight) -
    //     AppSizes.kMainBottomNavBarHeigth +
    //     10;

    // Top banner images
    final List<String> topBannerImages = home.topBanner
        .expand((b) => b.images.map((img) => img.image))
        .toList();

    // Footer banner images
    final List<String> footerBannerImages = home.footerBanner
        .expand((b) => b.images.map((img) => img.image))
        .toList();

    // final newArrivals = productsProvider.newArrivals;
    final featured = productsProvider.featured;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ==================== MAIn CAROUSEL FULL-HEIGHT BANNERS ====================
          HomeBanner(
            height: MediaQuery.of(context).size.height,
            // height: availableBannerHeight,
            title: home.title,
            count: home.topBanner.length,
            images: topBannerImages,
          ),

          // ==================== Featured products SECTION ====================
          SliverToBoxAdapter(
            child: HomeTextSection(
              title: 'Featured Products',
              route: AppRoutes.category,
              args: {'title': 'Featured Products', 'products': featured},
            ),
          ),

          // Featured Products
          SliverToBoxAdapter(
            child: SizedBox(height: 400, child: HomeListView(items: featured)),
          ),

          // Extra space at bottom
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ==================== MAIn CAROUSEL FULL-HEIGHT BANNERS ====================
          HomeBanner(
            height: 200,
            padding: 16,
            topForText: 30,
            topForButton: 112,
            title: home.title,
            count: home.footerBanner.length,
            images: footerBannerImages,
            // isFooter: true,
          ),

          Consumer<ProductsProvider>(
            builder: (context, productsProvider, _) {
              if (productsProvider.products.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox());
              }
              final firstProductId = productsProvider.products.first.productId;
              return SliverToBoxAdapter(
                child: RelatedProductsSection(
                  productId: firstProductId,
                  title: 'Related Products',
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.kMainBottomNavBarHeigth),
          ),
        ],
      ),
    );
  }
}
