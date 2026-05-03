import 'package:e_commerce_project/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

class DescriptionScreen extends StatelessWidget {
  final ProductModel product;
  const DescriptionScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Description')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(product.name, style: AppTextStyles.headlineMedium),
              SizedBox(height: 16.h),

              Text(product.description, style: AppTextStyles.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
