import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/features/screens/cart/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_project/core/theme/app_text_styles.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      body: cart.isEmpty
          ? _buildEmptyCart(context)
          : _buildCartContent(context, cart),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: AppSizes.kMainBottomNavBarHeigth + 16.h,
            ),
            child: AppElevatedButton(
              color: Color(0xFFF7F9FA),

              text: "SHOP NOW",
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.screens);
              },
            ),
          ),
        ],
      ),
    );
  }

  // حالة السلة مع المنتجات
  Widget _buildCartContent(BuildContext context, CartProvider cart) {
    final bool hasPromo = cart.discount > 0;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              top: 16.h,
              left: 16.w,
              right: 0,
              bottom: 0.h,
            ),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return _buildCartItem(context, cart.items[index], cart);
            },
          ),
        ),

        SizedBox(height: 16.h),

        // Voucher / Promo Code
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: hasPromo
              ? _buildPromoApplied(context, cart)
              : _buildVoucherInput(context, cart),
        ),

        // Order Summary
        Padding(
          padding: EdgeInsets.all(16.w),
          child: _buildOrderSummary(context, cart),
        ),

        // Checkout Button
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 16.h),
          child: AppElevatedButton(
            color: AppTheme.secondaryBackgroundColor,
            text: "PROCEED TO CHECKOUT",
            onPressed: () {},
          ),
        ),
        SizedBox(height: AppSizes.kMainBottomNavBarHeigth),
      ],
    );
  }

  // عنصر واحد في السلة (مع Swipe to Delete)
  Widget _buildCartItem(
    BuildContext context,
    CartItem item,
    CartProvider cart,
  ) {
    return Dismissible(
      key: Key(item.product.name + (item.selectedSize ?? '')),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 0.w),
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: AppImages.trashSvg(),
        ),
      ),
      onDismissed: (context) => cart.removeItem(item),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(right: 0.w, top: 0.h, bottom: 16.h, left: 0.w),
        child: InkWell(
          onTap: () {
            // Navigate to product details
            Navigator.pushNamed(
              context,
              AppRoutes.productDetail,
              arguments: item.product.productId,
            );
          },
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 150.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.r),
                        bottomLeft: Radius.circular(5.r),
                      ),
                      color: AppTheme.cardBackgroundColor,
                    ),
                    child: item.product.thumbnailUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: item.product.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorWidget: (_, _, _) => const SizedBox(),
                          )
                        : const SizedBox(),
                  ),
                  if (item.product.hasSale == true)
                    Positioned(
                      bottom: 10.h,
                      left: 10.w,
                      child: Container(
                        width: 33.w,
                        height: 16.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.borderColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        child: Text(
                          "SALE",
                          style: AppTextStyles.displayLarge.copyWith(
                            fontSize: 8.sp,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 16.w),
                  width: 120.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppTheme.borderColor),
                      bottom: BorderSide(color: AppTheme.borderColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12.w),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: AppTextStyles.bodyMedium,
                          ),
                          Row(
                            children: [
                              item.product.hasSale
                                  ? Text(
                                      '${item.product.currency} ${item.product.special}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  : Text(''),
                              SizedBox(width: 5.w),
                              Text(
                                '${item.product.currency} ${item.product.price}',
                                style: AppTextStyles.displaySmall,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Color: ${item.selectedColor ?? '-'}   Size: ${item.selectedSize ?? '-'}",
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.add,
                              size: 16.w,
                              color: cart.canIncrement(item)
                                  ? AppTheme.primaryColor
                                  : Colors.grey.shade400,
                            ),
                            onTap: () async {
                              final success = await cart.incrementQuantity(
                                item,
                              );
                              if (!success && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Only ${item.maxQuantity} available in stock',
                                    ),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }

                              // cart.updateQuantity(item, item.quantity + 1);
                            },
                          ),
                          Text("${item.quantity}"),
                          InkWell(
                            child: Icon(Icons.remove, size: 16.w),
                            onTap: () async {
                              final shouldAskRemove = await cart
                                  .decrementQuantity(item);
                              if (shouldAskRemove && context.mounted) {
                                final confirm = await _showRemoveDialog(
                                  context,
                                  item.product.name,
                                );
                                if (confirm == true) {
                                  cart.removeItem(item);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Confirmation dialog
  Future<bool?> _showRemoveDialog(BuildContext context, String productName) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Remove Item'),
        content: Text('Remove "$productName" from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherInput(BuildContext context, CartProvider cart) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "ENTER THE VOUCHER ",
              hintText: "Enter your promocode",
              hintStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Color(0XFFA0ADCC)),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor, Colors.black],
            ),
          ),
          child: FilledButton(
            onPressed: () => cart.applyPromoCode(10),
            clipBehavior: Clip.none,
            style: FilledButton.styleFrom(backgroundColor: Colors.transparent),
            child: const Text("APPLY"),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoApplied(BuildContext context, CartProvider cart) {
    return Container(
      padding: EdgeInsets.all(12.w),

      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          SizedBox(width: 8.w),
          Text("Promocode applied", style: AppTextStyles.headlineSmall),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartProvider cart) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFFF7F9FA),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          _summaryRow(
            context,
            "Subtotal",
            "\$${cart.subtotal.toStringAsFixed(2)}",
            isTotal: true,
          ),
          _summaryRow(
            context,
            "Delivery",
            "\$${cart.deliveryFee.toStringAsFixed(2)}",
            isDiscount: true,
          ),
          if (cart.discount > 0)
            _summaryRow(
              context,
              "Discount",
              "-\$${(cart.subtotal * cart.discount / 100).toStringAsFixed(2)}",
              isDiscount: true,
            ),
          Divider(height: 30.h),
          _summaryRow(
            context,
            "Total",
            "\$${cart.total.toStringAsFixed(2)}",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  color: AppTheme.primaryColor,
                )
              : AppTextStyles.bodyMedium,
        ),
        Text(value, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}
