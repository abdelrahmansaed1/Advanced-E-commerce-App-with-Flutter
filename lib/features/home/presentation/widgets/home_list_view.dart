import 'package:e_commerce_project/core/widgets/app_product_card.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class HomeListView extends StatelessWidget {
  final List<ProductsModel> items;
  const HomeListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final product = items[index];

        return AppProductCard(product: product);
      },
    );
  }
}
