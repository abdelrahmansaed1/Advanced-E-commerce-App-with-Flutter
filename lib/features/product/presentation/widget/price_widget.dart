import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final ProductsModel product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const PriceWidget({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Old price if on sale
          if (product.hasSale)
            Text(
              '\$${product.oldPrice}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                height: 1.7,
                decoration: TextDecoration.lineThrough,
              ),
            )
          else
            const SizedBox.shrink(),

          const SizedBox(width: 8),

          // Current price
          Text(
            '\$${product.price}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              height: 1.7,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          // Quantity controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: const Icon(Icons.remove, size: 16),
              ),
              const SizedBox(width: 16),
              Text(
                quantity.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onIncrement,
                child: const Icon(Icons.add, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
