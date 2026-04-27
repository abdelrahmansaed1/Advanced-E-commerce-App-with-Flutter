import 'package:e_commerce_project/core/widgets/product_card.dart';
import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class HomeListView extends StatelessWidget {
  final List<ProductModel> items;
  const HomeListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final product = items[index];

        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ProductCard(product: product),
        );
      },
    );
  }
}
