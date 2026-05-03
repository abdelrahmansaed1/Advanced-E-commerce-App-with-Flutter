import 'package:e_commerce_project/core/widgets/product_card.dart';
import 'package:e_commerce_project/features/relatedproducts/provider/related_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

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
  @override
  void initState() {
    super.initState();
    // ✅ Load immediately — widget only exists after user scrolled
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
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
        if (provider.state == RelatedProductsState.loading ||
            provider.state == RelatedProductsState.idle) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 24.w),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (provider.products.isEmpty) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
              child: Text(widget.title, style: AppTextStyles.headlineMedium),
            ),
            SizedBox(
              height: 400.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: provider.products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: ProductCard(product: provider.products[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }
}
