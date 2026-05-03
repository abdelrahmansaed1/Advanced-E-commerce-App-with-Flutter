import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/category/Provider/products_provider.dart';
import 'package:e_commerce_project/features/category/presentation/widgets/custom_popup.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/core/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

class Category extends StatefulWidget {
  final String? title;

  const Category({super.key, this.title});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final ScrollController _scrollController = ScrollController();

  String _currentSorting = 'best_match';
  final List<Map<String, String>> _sortingOptions = [
    {'value': 'best_match', 'label': 'Best match'},
    {'value': 'price_low', 'label': 'Price: low to high'},
    {'value': 'price_high', 'label': 'Price: high to low'},
    {'value': 'newest', 'label': 'Newest'},
    {'value': 'rating', 'label': 'Customer rating'},
    {'value': 'popular', 'label': 'Most popular'},
  ];
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProductsProvider>().loadProducts(catId: 1);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<ProductsProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    // Loading
    if (provider.state == ProductsState.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Error
    if (provider.state == ProductsState.error) {
      return Scaffold(
        appBar: MainAppBar(title: widget.title, showBackButton: true),
        body: Center(child: Text(provider.errorMessage ?? 'Error')),
      );
    }
    final products = provider.products;
    return Scaffold(
      appBar: MainAppBar(title: widget.title, showBackButton: true),
      body: Column(
        children: [
          // Filters and Sorting Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filters
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      AppImages.filterSvg(),
                      SizedBox(width: 6.w),
                      Text("Filters", style: AppTextStyles.bodyMedium),
                    ],
                  ),
                ),

                // Sorting
                GestureDetector(
                  onTap: _showSortingSheet,
                  child: Row(
                    children: [
                      Text("Sorting by", style: AppTextStyles.bodyMedium),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16.w,
                        color: AppTheme.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Products Grid
          // Expanded(
          //   child: GridView.builder(
          //     controller: _scrollController,
          //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2, // عمودين
          //       crossAxisSpacing: 16.w,
          //       mainAxisSpacing: 16.h,
          //       childAspectRatio: 0.41.h,
          //     ),
          //     itemCount: products.length,
          //     itemBuilder: (context, index) {
          //       return ProductCard(product: products[index]);
          //     },
          //   ),
          // ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;

                final horizontalPadding = 32.w; // 16 + 16
                final spacing = 16.w; // بين العناصر

                final itemWidth =
                    (screenWidth - horizontalPadding - spacing) / 2;

                // 👇 هنا تحدد شكل الكارد
                final imageHeight = itemWidth * 1.6; // الصورة
                final textHeight = 60.h; // الاسم + السعر
                final buttonHeight = 50.h; // زر
                final totalHeight = imageHeight + textHeight + buttonHeight;

                final aspectRatio = itemWidth / totalHeight;

                return GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: aspectRatio, // ✅ dynamic
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
              },
            ),
          ),
          if (provider.state == ProductsState.loadingMore)
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(bottom: 64.h, top: 16.h),
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showSortingSheet() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => CustomPopup(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _sortingOptions.map((option) {
            final bool isSelected = _currentSorting == option['value'];
            return _buildOption(
              label: option['label']!,
              value: option['value']!,
              isSelected: isSelected,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOption({
    required String label,
    required String value,
    required bool isSelected,
  }) {
    final bool isSelected = _currentSorting == value;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      trailing: isSelected
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.secondaryColor),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.circle_rounded,
                color: AppTheme.primaryColor,
                size: 24.w,
              ),
            )
          : Icon(Icons.circle_outlined, color: Colors.grey, size: 26.w),
      onTap: () {
        setState(() {
          _currentSorting = value;
        });
        Navigator.pop(context);
      },
    );
  }
}
