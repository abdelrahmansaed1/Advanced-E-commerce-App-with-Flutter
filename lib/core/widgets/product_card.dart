import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Widget imagePath = product.image?.isNotEmpty == true
        ? Image.asset(product.image!, fit: BoxFit.cover)
        : Container();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productDetail,
          arguments: product,
        );
      },
      child: SizedBox(
        width: 200,
        // margin: const EdgeInsets.only(right: 16),
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
                  // Product Image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: imagePath,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: AppImages.heartSvg(
                      width: 16,
                      height: 16,
                      color: Color(0xff495E72),
                    ),
                  ),

                  // SALE Tag
                  if (product.hasSale == true)
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

                  // Add Button
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: AppImages.addSvg(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // Price
            Row(
              children: [
                if (product.oldPrice != null) ...[
                  Text(
                    "\$${product.oldPrice}",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(width: 5),
                ],
                Text(
                  "\$${product.price}",
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
