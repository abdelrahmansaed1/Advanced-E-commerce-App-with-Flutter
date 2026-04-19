import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  final ProductsModel product;
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
                product.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              product.description == null
                  ? Text('No description')
                  : Text(
                      product.description!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
