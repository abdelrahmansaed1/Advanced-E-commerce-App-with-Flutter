import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/providers/cart_provider.dart';
import 'package:e_commerce_project/core/providers/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/features/onboarding/presentation/widgets/custom_dot_indicator.dart';
import 'package:e_commerce_project/features/product/presentation/widget/color_selecter.dart';
import 'package:e_commerce_project/features/product/presentation/widget/price_widget.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final PageController _controller = PageController();
  final ValueNotifier<double> _currentPageNotifier = ValueNotifier(0.0);

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  String colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0')}';
  }

  @override
  void initState() {
    super.initState();

    // هذا هو الجزء المهم اللي كان ناقص
    _controller.addListener(() {
      if (_controller.page != null) {
        _currentPageNotifier.value = _controller.page!;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                ProductImage(
                  product: widget.product,
                  controller: _controller,
                  currentPageNotifire: _currentPageNotifier,
                ),

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
                                widget.product.rating.toString(),

                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Price Widget and Quantity ,
                      PriceWidget(
                        product: widget.product,
                        quantity: quantity,
                        onIncrement: () => setState(() => quantity++),
                        onDecrement: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                      ),
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
            child: AppElevatedButton(
              text: "ADD TO CART",
              onPressed: () {
                final cartProvider = Provider.of<CartProvider>(
                  context,
                  listen: false,
                );

                cartProvider.addProduct(
                  widget.product,
                  quantity: quantity,
                  selectedSize: selectedSize,
                  selectedColor: colorToHex(selectedColor),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${widget.product.title} added to cart'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  final ProductsModel product;
  final PageController controller;
  final ValueNotifier<double> currentPageNotifire;
  const ProductImage({
    super.key,
    required this.controller,
    required this.currentPageNotifire,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Product Image
        Container(
          height: 375,
          width: double.infinity,
          color: AppTheme.cardBackgroundColor,
          child: PageView.builder(
            controller: controller,
            itemCount: product.image != null && product.image!.isNotEmpty
                ? product.image!.length
                : 3,
            itemBuilder: (context, index) {
              return product.image != null && product.image!.isNotEmpty
                  ? Image.asset(
                      product.image != null && product.image!.isNotEmpty
                          ? product.image![index]
                          : "",
                      fit: BoxFit.cover,
                    )
                  : Text('');
            },
          ),
        ),

        // Favorite Icon
        Positioned(
          bottom: 12,
          right: 12,

          child: Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, _) {
              final isFav = wishlistProvider.isFavorite(product);
              return GestureDetector(
                onTap: () => wishlistProvider.toggleFavorite(product),
                child: AppImages.heartSvg(
                  width: 24,
                  height: 24,
                  color: Color(0xff495E72),
                  isFilled: isFav,
                ),
              );
            },
          ),
        ),

        // SALE Tag
        if (product.hasSale == true)
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
          child: ValueListenableBuilder<double>(
            valueListenable: currentPageNotifire,
            builder: (context, value, child) {
              return CustomDotIndicator(
                length: product.image != null && product.image!.isNotEmpty
                    ? product.image!.length
                    : 3,
                currentPage: value,
              );
            },
          ),
        ),
      ],
    );
  }
}
