import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/features/screens/wishlist/provider/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          final products = wishlistProvider.favorites;

          if (products.isEmpty) {
            return Center(
              child: Text(
                "Your wishlist is empty",
                style: TextStyle(fontSize: 18.sp),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.productDetail,
                    arguments: product.productId,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    right: 0,
                    top: 8.h,
                    bottom: 8.h,
                    left: 16.w,
                  ),
                  child: Row(
                    children: [
                      // Product Image + SALE tag
                      Stack(
                        children: [
                          Container(
                            height: 140.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.r),
                                bottomLeft: Radius.circular(5.r),
                              ),
                              color: AppTheme.cardBackgroundColor,
                            ),
                            child: product.thumbnailUrl.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: product.thumbnailUrl,
                                    fit: BoxFit.cover,
                                    errorWidget: (_, _, _) => const SizedBox(),
                                  )
                                : const SizedBox(),
                          ),
                          if (product.hasSale == true)
                            Positioned(
                              bottom: 10.h,
                              left: 10.w,
                              child: Container(
                                width: 33.w,
                                height: 16.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 1.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppTheme.borderColor,
                                  ),
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
                        ],
                      ),

                      // Product Details
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 16.w),
                          height: 140.h,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppTheme.borderColor),
                              bottom: BorderSide(color: AppTheme.borderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: AppTextStyles.bodyMedium,
                                    ),
                                    Row(
                                      children: [
                                        if (product.hasSale)
                                          Text(
                                            '\$${product.special} ',
                                            style: AppTextStyles.bodySmall
                                                .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 12.sp,
                                                ),
                                          ),
                                        // SizedBox(width: 5.w),
                                        Text(
                                          '\$${product.price}',
                                          style: AppTextStyles.displaySmall,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: AppTheme.secondaryColor,
                                          size: 10.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          product.rating.toString(),
                                          style: AppTextStyles.bodyMedium
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Spacer(),

                              // Heart + Add to Cart
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Heart (toggle favorite)
                                  GestureDetector(
                                    onTap: () {
                                      final wishlist =
                                          Provider.of<WishlistProvider>(
                                            context,
                                            listen: false,
                                          );
                                      wishlist.toggleFavorite(product);
                                    },
                                    child: AppImages.heartSvg(
                                      color: AppTheme.primaryColor,
                                      width: 22.w,
                                      height: 22.h,
                                      isFilled: wishlistProvider.isFavorite(
                                        product,
                                      ),
                                    ),
                                  ),

                                  // Add to Cart
                                  GestureDetector(
                                    onTap: () {
                                      final cartProvider =
                                          Provider.of<CartProvider>(
                                            context,
                                            listen: false,
                                          );

                                      cartProvider.addProduct(
                                        product,
                                        quantity: 1,
                                        selectedSize: "M",
                                        selectedColor: "Brown",
                                      );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${product.name} added to cart',
                                          ),
                                          duration: const Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    child: AppImages.addSvg(
                                      width: 22.w,
                                      height: 22.h,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
