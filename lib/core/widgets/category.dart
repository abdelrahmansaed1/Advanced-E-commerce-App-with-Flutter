import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/custom_popup.dart';
import 'package:e_commerce_project/core/widgets/main_app_bar.dart';
import 'package:e_commerce_project/core/widgets/product_card.dart';
import 'package:e_commerce_project/models/products_model.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final String? title;
  final List<ProductsModel>? products;

  const Category({super.key, this.title, this.products});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String _currentSorting = 'best_match';
  final List<Map<String, String>> _sortingOptions = [
    {'value': 'best_match', 'label': 'Best match'},
    {'value': 'price_low', 'label': 'Price: low to high'},
    {'value': 'price_high', 'label': 'Price: high to low'},
    {'value': 'newest', 'label': 'Newest'},
    {'value': 'rating', 'label': 'Customer rating'},
    {'value': 'popular', 'label': 'Most popular'},
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.title, showBackButton: true),
      body: Column(
        children: [
          // Filters and Sorting Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filters
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      AppImages.filterSvg(),
                      SizedBox(width: 6),
                      Text(
                        "Filters",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                // Sorting
                GestureDetector(
                  onTap: _showSortingSheet,
                  child: Row(
                    children: [
                      Text(
                        "Sorting by",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                        color: AppTheme.secondaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عمودين
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.55,
              ),
              itemCount: widget.products?.length ?? 0,
              itemBuilder: (context, index) {
                return ProductCard(product: widget.products![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSortingSheet() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => CustomPopup(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _sortingOptions.map((option) {
            final bool isSelected = _currentSorting == option['value'];
            return _buildOption(
              label: option['label']!,
              value: option['value']!,
              isSelected: isSelected,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOption({
    required String label,
    required String value,
    required bool isSelected,
  }) {
    final bool isSelected = _currentSorting == value;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      trailing: isSelected
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.secondaryColor),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.circle_rounded,
                color: AppTheme.primaryColor,
                size: 24,
              ),
            )
          : const Icon(Icons.circle_outlined, color: Colors.grey, size: 26),
      onTap: () {
        setState(() {
          _currentSorting = value;
        });
        Navigator.pop(context);
      },
    );
  }
}
