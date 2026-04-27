// import 'package:e_commerce_project/core/constants/app_images.dart';
// import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
// import 'package:e_commerce_project/features/screens/wishlist/provider/wishlist_provider.dart';
// import 'package:e_commerce_project/core/routes/app_routes.dart';
// import 'package:e_commerce_project/core/theme/app_theme.dart';
// import 'package:e_commerce_project/features/product/model/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProductCard extends StatefulWidget {
//   final ProductModel product;

//   const ProductCard({super.key, required this.product});

//   @override
//   State<ProductCard> createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   @override
//   Widget build(BuildContext context) {
//     bool isFavorite = widget.product.isFavorite;
//     final Widget imagePath = widget.product.image.isNotEmpty == true
//         ? Image.network(
//             widget.product.image.first.url,
//             fit: BoxFit.cover,
//             errorBuilder: (context, child, loadingProgress) =>
//                 Container(color: AppTheme.cardBackgroundColor),
//             loadingBuilder: (context, child, loadingProgress) {
//               if (loadingProgress == null) return child;
//               return Container(color: AppTheme.cardBackgroundColor);
//             },
//           )
//         : Container();
//     return GestureDetector(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           AppRoutes.productDetail,
//           arguments: widget.product.productId,
//         );
//       },
//       child: SizedBox(
//         width: 200,
//         // margin: const EdgeInsets.only(right: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 250,
//               decoration: BoxDecoration(
//                 color: AppTheme.cardBackgroundColor,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Stack(
//                 children: [
//                   // Product Image
//                   Positioned.fill(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(5),
//                       child: imagePath,
//                     ),
//                   ),
//                   Positioned(
//                     top: 12,
//                     right: 12,
//                     child: GestureDetector(
//                       onTap: () {
//                         final wishlistProvider = Provider.of<WishlistProvider>(
//                           context,
//                           listen: false,
//                         );
//                         wishlistProvider.toggleFavorite(widget.product);
//                         setState(() {
//                           isFavorite = widget.product.isFavorite;
//                         });
//                       },
//                       child: AppImages.heartSvg(
//                         width: 16,
//                         height: 16,
//                         color: Color(0xff495E72),
//                         isFilled: isFavorite,
//                       ),
//                     ),
//                   ),

//                   // SALE Tag
//                   if (widget.product.hasSale == true)
//                     Positioned(
//                       bottom: 14,
//                       left: 14,
//                       child: Container(
//                         width: 33,
//                         height: 16,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 6,
//                           vertical: 1,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: AppTheme.borderColor),
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         child: Text(
//                           "SALE",
//                           style: Theme.of(context).textTheme.displayLarge
//                               ?.copyWith(fontSize: 8, height: 1.6),
//                         ),
//                       ),
//                     ),

//                   // Add Button
//                   Positioned(
//                     bottom: 14,
//                     right: 14,
//                     child: GestureDetector(
//                       onTap: () {
//                         final cartProvider = Provider.of<CartProvider>(
//                           context,
//                           listen: false,
//                         );

//                         cartProvider.addProduct(
//                           widget.product,
//                           quantity: 1,
//                           selectedSize: "M",
//                           selectedColor: "Brown", // يمكن تغييره لاحقاً
//                         );

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               '${widget.product.name} added to cart',
//                             ),
//                             duration: const Duration(seconds: 1),
//                             behavior: SnackBarBehavior.floating,
//                           ),
//                         );
//                       },
//                       child: Container(
//                         child: AppImages.addSvg(
//                           width: 18,
//                           height: 18,
//                           color: AppTheme.primaryColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 12),

//             // Title
//             Text(
//               widget.product.name,
//               style: Theme.of(context).textTheme.bodyMedium,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),

//             const SizedBox(height: 6),

//             // Price
//             Row(
//               children: [
//                 ...[
//                   Text(
//                     "\$${widget.product.special}",
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                 ],
//                 Text(
//                   "\$${widget.product.price}",
//                   style: Theme.of(context).textTheme.displaySmall,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/features/screens/wishlist/provider/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
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
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: AppTheme.cardBackgroundColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                children: [
                  // ✅ Use thumbnailUrl for the card (not image list)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: widget.product.thumbnailUrl.isNotEmpty
                          ? Image.network(
                              widget.product.thumbnailUrl,
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  color: AppTheme.cardBackgroundColor,
                                );
                              },
                              errorBuilder: (_, _, _) => Container(
                                color: AppTheme.cardBackgroundColor,
                              ),
                            )
                          : Container(color: AppTheme.cardBackgroundColor),
                    ),
                  ),

                  // Favorite button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<WishlistProvider>(
                          context,
                          listen: false,
                        ).toggleFavorite(widget.product);
                        setState(() {
                          isFavorite = widget.product.isFavorite;
                        });
                      },
                      child: AppImages.heartSvg(
                        width: 16,
                        height: 16,
                        color: const Color(0xff495E72),
                        isFilled: isFavorite,
                      ),
                    ),
                  ),

                  // ✅ SALE tag — only when hasSale is true
                  if (widget.product.hasSale)
                    Positioned(
                      bottom: 14,
                      left: 14,
                      child: Container(
                        width: 33,
                        height: 16,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.borderColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          "SALE",
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(fontSize: 8, height: 1.6),
                        ),
                      ),
                    ),

                  // Add to cart button
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<CartProvider>(
                          context,
                          listen: false,
                        ).addProduct(
                          widget.product,
                          quantity: 1,
                          selectedSize: "M",
                          selectedColor: "Brown",
                        );
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
                      child: AppImages.addSvg(
                        width: 18,
                        height: 18,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Product name
            Text(
              widget.product.name,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // ✅ Price row — old price only shown when hasSale is true
            Row(
              children: [
                if (widget.product.hasSale) ...[
                  Text(
                    "${widget.product.currency} ${widget.product.special}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
                Text(
                  "${widget.product.currency} ${widget.product.price}",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
