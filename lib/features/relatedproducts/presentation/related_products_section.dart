import 'package:e_commerce_project/core/di/injection_container.dart' as di;
import 'package:e_commerce_project/core/widgets/product_card.dart';
import 'package:e_commerce_project/features/relatedproducts/data/repositories/related_product_repository.dart';
import 'package:e_commerce_project/features/relatedproducts/provider/related_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RelatedProductsSection extends StatelessWidget {
  final String productId;
  final String title;

  const RelatedProductsSection({
    super.key,
    required this.productId,
    this.title = 'You May Also Like',
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Create and scope the provider right here inside the widget
    return ChangeNotifierProvider(
      create: (_) => RelatedProductsProvider(
        repository: di.sl<RelatedProductsRepository>(),
      )..loadRelatedProducts(productId: productId),
      child: Consumer<RelatedProductsProvider>(
        builder: (context, provider, _) {
          if (provider.state == RelatedProductsState.loading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (provider.products.isEmpty) return const SizedBox();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: 320,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(product: provider.products[index]),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
