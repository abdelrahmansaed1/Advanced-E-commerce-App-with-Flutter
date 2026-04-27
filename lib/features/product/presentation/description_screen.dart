import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  final ProductModel product;
  const DescriptionScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Description')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                product.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16),

              Text(
                product.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
