import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/features/onboarding/presentation/widgets/custom_dot_indicator.dart';
import 'package:e_commerce_project/features/product/model/product_detail_model.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:e_commerce_project/features/product/presentation/widget/color_selecter.dart';
import 'package:e_commerce_project/features/product/presentation/widget/price_widget.dart';
import 'package:e_commerce_project/features/product/provider/product_detail_provider.dart';
import 'package:e_commerce_project/features/relatedproducts/presentation/related_products_section.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/features/screens/wishlist/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _controller = PageController();
  final ValueNotifier<double> _currentPageNotifier = ValueNotifier(0.0);
  Color selectedColor = Colors.brown;

  // ✅ Cache the converted ProductModel so wishlist isFavorite works consistently
  ProductModel? _cachedProductModel;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page != null) {
        _currentPageNotifier.value = _controller.page!;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  String colorToHex(Color color) =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0')}';

  // ✅ Convert ProductDetailModel → ProductModel once and cache it
  ProductModel _toProductModel(ProductDetailModel product) {
    _cachedProductModel ??= ProductModel(
      productId: product.productId,
      sku: product.sku,
      name: product.name,
      price: product.price,
      special: product.hasSale ? product.special : '0',
      thumbnailUrl: product.images.isNotEmpty ? product.images.first : '',
      image: product.images.map((url) => ProductImageModel(url: url)).toList(),
      currency: product.currency,
      discountPercentage: product.discountPercentage,
      description: product.description,
      isNew: product.isNew,
      isBestseller: product.isBestseller,
      showLabel: false,
      labels: [],
      rating: product.rating.toString(),
    );
    return _cachedProductModel!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailProvider>(
      builder: (context, provider, _) {
        if (provider.state == ProductDetailState.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.state == ProductDetailState.error) {
          return Scaffold(
            appBar: MainAppBar(showBackButton: true),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.errorMessage ?? 'Something went wrong'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        provider.loadProduct(productId: widget.productId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        final product = provider.product;
        if (product == null) return const Scaffold();

        // ✅ Build once per product load
        final productModel = _toProductModel(product);

        return Scaffold(
          appBar: MainAppBar(showBackButton: true),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(product, productModel),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  product.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppTheme.secondaryColor,
                                    size: 10,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    // ✅ rating is double, format it cleanly
                                    product.rating > 0
                                        ? product.rating.toStringAsFixed(1)
                                        : 'N/A',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          PriceWidget(
                            price: product.price,
                            special: product.hasSale ? product.special : null,
                            currency: product.currency,
                            quantity: provider.quantity,
                            onIncrement: provider.increment,
                            onDecrement: provider.decrement,
                          ),

                          const SizedBox(height: 16),

                          // Sizes
                          if (product.sizes.isNotEmpty) ...[
                            const Text(
                              "Size",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: product.sizes.map((size) {
                                  final bool isSelected =
                                      provider.selectedSize == size.label;
                                  final bool isAvailable = size.isAvailable;

                                  return GestureDetector(
                                    onTap: isAvailable
                                        ? () => provider.selectSize(size.label)
                                        : null,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppTheme.primaryColor
                                            : isAvailable
                                            ? const Color(0xFFFAFCFE)
                                            : Colors.grey.shade200,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        size.label,
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppTheme.backgroundColor
                                              : isAvailable
                                              ? AppTheme.primaryColor
                                              : Colors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          decoration: isAvailable
                                              ? null
                                              : TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],

                          const SizedBox(height: 24),

                          ColorSelector(
                            colors: const [
                              Color(0xFFFFE4C4),
                              Color(0xFFADD8E6),
                              Color(0xFF8FBC8F),
                              Color(0xFFCD853F),
                              Color(0xFF2C2C2C),
                            ],
                            initialSelectedColor: Colors.brown,
                            onColorSelected: (color) {
                              setState(() => selectedColor = color);
                            },
                          ),

                          const SizedBox(height: 30),

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
                            product.description,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(height: 1.7),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.description,
                                arguments: product.description,
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "read more",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(height: 1.7),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                  color: AppTheme.secondaryColor,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    RelatedProductsSection(
                      productId: widget.productId,
                      title: 'You May Also Like',
                    ),
                  ],
                ),
              ),

              // Add to Cart
              Positioned(
                bottom: 32,
                left: 32,
                right: 32,
                child: AppElevatedButton(
                  text: product.isOutOfStock ? "OUT OF STOCK" : "ADD TO CART",
                  onPressed: product.isOutOfStock
                      ? null // ✅ null disables the button properly
                      : () {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).addProduct(
                            productModel, // ✅ use the cached converted model
                            quantity: provider.quantity,
                            selectedSize: provider.selectedSize,
                            selectedColor: colorToHex(selectedColor),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} added to cart'),
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
      },
    );
  }

  Widget _buildImageSection(
    ProductDetailModel product,
    ProductModel productModel, // ✅ receive the cached model
  ) {
    return Stack(
      children: [
        Container(
          height: 550,
          width: double.infinity,
          color: AppTheme.cardBackgroundColor,
          child: product.images.isEmpty
              ? Container(color: AppTheme.cardBackgroundColor)
              : PageView.builder(
                  controller: _controller,
                  itemCount: product.images.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: product.images[index],
                      fit: BoxFit.fill,
                      placeholder: (context, url) {
                        return Container(color: AppTheme.cardBackgroundColor);
                      },
                      errorWidget: (context, url, error) =>
                          Container(color: AppTheme.cardBackgroundColor),
                    );
                  },
                ),
        ),

        // ✅ Favorite icon uses the cached productModel — isFavorite is stable
        Positioned(
          bottom: 12,
          right: 12,
          child: Consumer<WishlistProvider>(
            builder: (context, wishlist, _) {
              return GestureDetector(
                onTap: () => wishlist.toggleFavorite(productModel),
                child: AppImages.heartSvg(
                  width: 24,
                  height: 24,
                  color: const Color(0xff495E72),
                  isFilled: wishlist.isFavorite(productModel),
                ),
              );
            },
          ),
        ),

        // Dot indicator
        if (product.images.length > 1)
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<double>(
              valueListenable: _currentPageNotifier,
              builder: (context, value, _) {
                return CustomDotIndicator(
                  length: product.images.length,
                  currentPage: value,
                );
              },
            ),
          ),
      ],
    );
  }
}
