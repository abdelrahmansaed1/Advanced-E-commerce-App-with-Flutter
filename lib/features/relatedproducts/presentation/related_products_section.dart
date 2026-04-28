// import 'package:e_commerce_project/core/di/injection_container.dart' as di;
// import 'package:e_commerce_project/core/widgets/product_card.dart';
// import 'package:e_commerce_project/features/relatedproducts/data/repositories/related_product_repository.dart';
// import 'package:e_commerce_project/features/relatedproducts/provider/related_product_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class RelatedProductsSection extends StatelessWidget {
//   final String productId;
//   final String title;

//   const RelatedProductsSection({
//     super.key,
//     required this.productId,
//     this.title = 'You May Also Like',
//   });

//   @override
//   Widget build(BuildContext context) {
//     // ✅ Create and scope the provider right here inside the widget
//     return ChangeNotifierProvider(
//       create: (_) => RelatedProductsProvider(
//         repository: di.sl<RelatedProductsRepository>(),
//       )..loadRelatedProducts(productId: productId),
//       child: Consumer<RelatedProductsProvider>(
//         builder: (context, provider, _) {
//           if (provider.state == RelatedProductsState.loading) {
//             return const Padding(
//               padding: EdgeInsets.symmetric(vertical: 24),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }

//           if (provider.products.isEmpty) return const SizedBox();

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
//                 child: Text(
//                   title,
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//               ),
//               SizedBox(
//                 height: 400,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: provider.products.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 16),
//                       child: ProductCard(product: provider.products[index]),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:e_commerce_project/core/widgets/product_card.dart';
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
    // ✅ No ChangeNotifierProvider here — use the global one
    return _RelatedProductsBody(productId: productId, title: title);
  }
}

class _RelatedProductsBody extends StatefulWidget {
  final String productId;
  final String title;

  const _RelatedProductsBody({required this.productId, required this.title});

  @override
  State<_RelatedProductsBody> createState() => _RelatedProductsBodyState();
}

class _RelatedProductsBodyState extends State<_RelatedProductsBody> {
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    // Load after a short delay — gives page time to render first
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted && !_hasTriggered) {
        _hasTriggered = true;
        context.read<RelatedProductsProvider>().loadRelatedProducts(
          productId: widget.productId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RelatedProductsProvider>(
      builder: (context, provider, _) {
        if (provider.state == RelatedProductsState.idle ||
            provider.state == RelatedProductsState.loading) {
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
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(
              height: 400,
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
    );
  }
}
