// lib/features/product/presentation/product_detail_page.dart

import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/core/widgets/app_list_item.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/features/onboarding/presentation/widgets/custom_dot_indicator.dart';
import 'package:e_commerce_project/features/product/presentation/widget/color_selecter.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductsModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String selectedSize = 'M';
  int quantity = 1;
  Color selectedColor = Colors.brown;

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(showBackButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ProductImage(widget: widget),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.title,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppTheme.secondaryColor,
                                size: 10,
                              ),
                              SizedBox(width: 4),
                              Text(
                                // widget.product.rating.toString(),
                                '4,5',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      PriceWidget(widget: widget),
                      const SizedBox(height: 16),
                      // Size
                      const Text(
                        "Size",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: sizes.map((size) {
                          final bool isSelected = selectedSize == size;
                          return GestureDetector(
                            onTap: () => setState(() => selectedSize = size),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : Color(0XFFFAFCFE),
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                size,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppTheme.backgroundColor
                                      : AppTheme.primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      // Color
                      ColorSelector(
                        colors: const [
                          Color(0xFFFFE4C4), // beige
                          Color(0xFFADD8E6), // light blue
                          Color(0xFF8FBC8F), // sage green
                          Color(0xFFCD853F), // brown
                          Color(0xFF2C2C2C), // dark black
                        ],
                        initialSelectedColor: Colors.brown,
                        onColorSelected: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                          // يمكنك حفظ اللون هنا إذا أردت
                        },
                      ),

                      const SizedBox(height: 30),

                      // Description
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${widget.product.description}',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(height: 1.7),
                        maxLines: 6,
                      ),

                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.description,
                            arguments: widget.product,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "read more",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(height: 1.7),
                            ),

                            Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: AppTheme.secondaryColor,
                            ),
                          ],
                        ),
                      ),

                      // Add to Cart Button
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            right: 32,
            child: AppElevatedButton(text: "ADD TO CART", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, required this.widget});

  final ProductDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide.none,
          top: BorderSide(width: 1, color: AppTheme.borderColor),
          bottom: BorderSide(width: 1, color: AppTheme.borderColor),
          left: BorderSide(width: 1, color: AppTheme.borderColor),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          widget.product.hasSale
              ? Text(
                  '\$${widget.product.oldPrice}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    height: 1.7,
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              : const Text(''),
          const SizedBox(width: 8),
          Text(
            '\$${widget.product.price}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              height: 1.7,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.widget});

  final ProductDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Product Image
        Container(
          height: 375,
          width: double.infinity,
          color: AppTheme.cardBackgroundColor,
          child: Image.asset(
            widget.product.image ?? '',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                const Icon(Icons.image_not_supported, size: 100),
          ),
        ),

        // Favorite Icon
        Positioned(
          bottom: 12,
          right: 12,
          child: AppImages.heartSvg(
            width: 24,
            height: 24,
            color: Color(0xff495E72),
          ),
        ),

        // SALE Tag
        if (widget.product.hasSale == true)
          Positioned(
            top: 6,
            left: 20,
            child: Container(
              width: 58,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.borderColor),
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  "SALE",

                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge?.copyWith(fontSize: 12, height: 1.7),
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 14,
          left: 0,
          right: 0,
          child: CustomDotIndicator(length: 3, currentPage: 0),
        ),
      ],
    );
  }
}

// // Color Dot Widget
// class ColorDot extends StatelessWidget {
//   final Color color;

//   const ColorDot({super.key, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 32,
//       height: 32,
//       decoration: BoxDecoration(
//         color: color,
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//     );
//   }
// }
