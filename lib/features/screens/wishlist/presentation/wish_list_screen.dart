// import 'package:e_commerce_project/core/constants/app_images.dart';
// import 'package:e_commerce_project/core/data/dummy_data.dart';
// import 'package:e_commerce_project/core/providers/cart_provider.dart';
// import 'package:e_commerce_project/core/routes/app_routes.dart';
// import 'package:e_commerce_project/core/theme/app_theme.dart';
// import 'package:e_commerce_project/models/products_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WishListPage extends StatelessWidget {
//   const WishListPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     bool isFavorite = true;
//     final List<ProductsModel> products = DummyData.allProducts
//         .where((product) => product.isFavorite == true)
//         .toList();
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(
//                 context,
//                 AppRoutes.productDetail,
//                 arguments: product,
//               );
//             },
//             child: Container(
//               width: double.infinity,
//               padding: EdgeInsets.only(right: 0, top: 8, bottom: 8, left: 16),
//               child: Row(
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         height: 100,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(5),
//                             bottomLeft: Radius.circular(5),
//                           ),
//                           color: AppTheme.cardBackgroundColor,
//                         ),
//                         child:
//                             product.image != null && product.image!.isNotEmpty
//                             ? Image.asset(
//                                 products.elementAt(index).image!.first,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     const Text(''),
//                               )
//                             : const Text(''),
//                       ),
//                       if (product.hasSale == true)
//                         Positioned(
//                           bottom: 10,
//                           left: 10,
//                           child: Container(
//                             width: 33,
//                             height: 16,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 6,
//                               vertical: 1,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: AppTheme.borderColor),
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(3),
//                             ),
//                             child: Text(
//                               "SALE",
//                               style: Theme.of(context).textTheme.displayLarge
//                                   ?.copyWith(fontSize: 8, height: 1.6),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.only(right: 16),
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         border: Border(
//                           top: BorderSide(color: AppTheme.borderColor),
//                           bottom: BorderSide(color: AppTheme.borderColor),
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           const SizedBox(width: 12),

//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 product.title,
//                                 style: Theme.of(context).textTheme.bodyMedium,
//                               ),
//                               Row(
//                                 children: [
//                                   product.hasSale
//                                       ? Text(
//                                           '\$${product.oldPrice}',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall
//                                               ?.copyWith(
//                                                 decoration:
//                                                     TextDecoration.lineThrough,
//                                                 fontSize: 12,
//                                               ),
//                                         )
//                                       : Text(''),
//                                   SizedBox(width: 5),
//                                   Text(
//                                     '\$${product.price}',
//                                     style: Theme.of(
//                                       context,
//                                     ).textTheme.displaySmall,
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     color: AppTheme.secondaryColor,
//                                     size: 10,
//                                   ),
//                                   SizedBox(width: 4),
//                                   Text(
//                                     product.rating.toString(),

//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium
//                                         ?.copyWith(fontSize: 12),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Spacer(),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   child: AppImages.heartSvg(
//                                     color: AppTheme.primaryColor,
//                                     width: 16,
//                                     height: 16,
//                                     isFilled: true,
//                                   ),
//                                 ),
//                               ),

//                               GestureDetector(
//                                 onTap: () {
//                                   final cartProvider =
//                                       Provider.of<CartProvider>(
//                                         context,
//                                         listen: false,
//                                       );

//                                   cartProvider.addProduct(
//                                     product,
//                                     quantity: 1,
//                                     selectedSize: "M",
//                                     selectedColor:
//                                         "Brown", // يمكن تغييره لاحقاً
//                                   );

//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         '${product.title} added to cart',
//                                       ),
//                                       duration: const Duration(seconds: 1),
//                                       behavior: SnackBarBehavior.floating,
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   child: AppImages.addSvg(
//                                     width: 18,
//                                     height: 18,
//                                     color: AppTheme.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/providers/cart_provider.dart';
import 'package:e_commerce_project/core/providers/wishlist_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';
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
            return const Center(
              child: Text(
                "Your wishlist is empty",
                style: TextStyle(fontSize: 18),
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
                    arguments: product,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    right: 0,
                    top: 8,
                    bottom: 8,
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      // Product Image + SALE tag
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              color: AppTheme.cardBackgroundColor,
                            ),
                            child:
                                product.image != null &&
                                    product.image!.isNotEmpty
                                ? Image.asset(
                                    product.image!.first,
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox(),
                          ),
                          if (product.hasSale == true)
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                width: 33,
                                height: 16,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppTheme.borderColor,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  "SALE",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(fontSize: 8, height: 1.6),
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Product Details
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 16),
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppTheme.borderColor),
                              bottom: BorderSide(color: AppTheme.borderColor),
                            ),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                    Row(
                                      children: [
                                        if (product.hasSale)
                                          Text(
                                            '\$${product.oldPrice}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '\$${product.price}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displaySmall,
                                        ),
                                      ],
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
                                          product.rating.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),

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
                                      width: 22,
                                      height: 22,
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
                                            '${product.title} added to cart',
                                          ),
                                          duration: const Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    },
                                    child: AppImages.addSvg(
                                      width: 22,
                                      height: 22,
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
