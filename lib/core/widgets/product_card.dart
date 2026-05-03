import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/features/screens/wishlist/provider/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // ✅ Moved outside build() so setState works correctly
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productDetail,
          arguments: widget.product.productId,
        );
      },
      child: SizedBox(
        width: 200.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300.h,
              decoration: BoxDecoration(
                color: AppTheme.cardBackgroundColor,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Stack(
                children: [
                  // ✅ Use thumbnailUrl for the card (not image list)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: widget.product.thumbnailUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: widget.product.thumbnailUrl,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, child, progress) {
                                    return Container(
                                      color: AppTheme.cardBackgroundColor,
                                    );
                                  },
                              errorWidget: (_, _, _) => Container(
                                color: AppTheme.cardBackgroundColor,
                              ),
                            )
                          : Container(color: AppTheme.cardBackgroundColor),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: Consumer<WishlistProvider>(
                      builder: (context, wishlistProvider, child) {
                        // Update isFavorite based on the provider's state
                        bool isFavorite = wishlistProvider.isFavorite(
                          widget.product,
                        );
                        return InkWell(
                          onTap: () {
                            wishlistProvider.toggleFavorite(widget.product);
                          },
                          child: AppImages.heartSvg(
                            width: 16.w,
                            height: 16.h,
                            color: const Color(0xff495E72),
                            isFilled: isFavorite,
                          ),
                        );
                      },
                    ),
                  ),

                  // ✅ SALE tag — only when hasSale is true
                  if (widget.product.hasSale)
                    Positioned(
                      bottom: 14.h,
                      left: 14.w,
                      child: Container(
                        width: 33.w,
                        height: 16.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.borderColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        child: Text(
                          "SALE",
                          style: AppTextStyles.displayLarge.copyWith(
                            fontSize: 8.sp,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),

                  // Add to cart button
                  // Positioned(
                  //   bottom: 14,
                  //   right: 14,
                  //   child: InkWell(
                  //     onTap: () {
                  //       Provider.of<CartProvider>(
                  //         context,
                  //         listen: false,
                  //       ).addProduct(
                  //         widget.product,
                  //         quantity: 1,
                  //         selectedSize: "M",
                  //         selectedColor: "Brown",
                  //       );
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text(
                  //             '${widget.product.name} added to cart',
                  //           ),
                  //           duration: const Duration(seconds: 1),
                  //           behavior: SnackBarBehavior.floating,
                  //         ),
                  //       );
                  //     },
                  //     child: AppImages.addSvg(
                  //       width: 18.w,
                  //       height: 18.h,
                  //       color: AppTheme.primaryColor,
                  //     ),
                  //   ),
                  // ),
                  // Add to Cart Button - Smart Version
                  Positioned(
                    bottom: 14.h,
                    right: 14.w,
                    child: Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        // Find if this product exists in cart
                        final cartItem = cartProvider.items.firstWhereOrNull(
                          (item) =>
                              item.product.productId ==
                              widget.product.productId,
                        );

                        final quantity = cartItem?.quantity ?? 0;

                        return InkWell(
                          onTap: () {
                            if (quantity == 0) {
                              // First time add
                              cartProvider.addProduct(
                                widget.product,
                                quantity: 1,
                                selectedSize: "M",
                                selectedColor: "Brown",
                              );
                            } else {
                              // Increase quantity
                              if (cartItem != null) {
                                cartProvider.updateQuantity(
                                  cartItem,
                                  quantity + 1,
                                );
                              }
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${widget.product.name} added to cart',
                                ),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },

                          child: Container(
                            width: 18.w,
                            height: 18.h,
                            decoration: quantity != 0
                                ? BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    shape: BoxShape.circle,
                                  )
                                : BoxDecoration(),
                            child: Center(
                              child: quantity == 0
                                  ? AppImages.addSvg(
                                      width: 18.w,
                                      height: 18.h,
                                      color: AppTheme.primaryColor,
                                    )
                                  : Text(
                                      "$quantity",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            AppTheme.secondaryBackgroundColor,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Product name
            Text(
              widget.product.name,
              style: AppTextStyles.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 6.h),

            // ✅ Price row — old price only shown when hasSale is true
            Row(
              children: [
                if (widget.product.hasSale) ...[
                  Text(
                    "${widget.product.currency} ${widget.product.special}",
                    style: AppTextStyles.bodySmall.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(width: 5.w),
                ],
                Text(
                  "${widget.product.currency} ${widget.product.price}",
                  style: AppTextStyles.displaySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
