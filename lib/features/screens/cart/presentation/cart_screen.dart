import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_project/core/constants/app_images.dart';
import 'package:e_commerce_project/core/constants/app_sizes.dart';
import 'package:e_commerce_project/features/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_project/core/routes/app_routes.dart';
import 'package:e_commerce_project/core/theme/app_theme.dart';
import 'package:e_commerce_project/core/widgets/app_elevated_button.dart';
import 'package:e_commerce_project/features/screens/cart/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              horizontal: 16.0,
              vertical: AppSizes.kMainBottomNavBarHeigth + 16,
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
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 0,
              bottom: 16,
            ),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return _buildCartItem(context, cart.items[index], cart);
            },
          ),
        ),

        // Voucher / Promo Code
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: hasPromo
              ? _buildPromoApplied(context, cart)
              : _buildVoucherInput(context, cart),
        ),

        // Order Summary
        Padding(
          padding: const EdgeInsets.all(16),
          child: _buildOrderSummary(context, cart),
        ),

        // Checkout Button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
        padding: const EdgeInsets.only(right: 0),
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppImages.trashSvg(),
        ),
      ),
      onDismissed: (context) => cart.removeItem(item),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(right: 0, top: 8, bottom: 8, left: 16),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    color: AppTheme.cardBackgroundColor,
                  ),
                  child: item.product.thumbnailUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: item.product.thumbnailUrl,
                          fit: BoxFit.fill,
                          errorWidget: (_, _, _) => const SizedBox(),
                        )
                      : const SizedBox(),
                ),
                if (item.product.hasSale == true)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      width: 33,
                      height: 16,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.borderColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        "SALE",
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(fontSize: 8, height: 1.6),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppTheme.borderColor),
                    bottom: BorderSide(color: AppTheme.borderColor),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            item.product.hasSale
                                ? Text(
                                    '\$${item.product.special}',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 12,
                                        ),
                                  )
                                : Text(''),
                            SizedBox(width: 5),
                            Text(
                              '\$${item.product.price}',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Color: ${item.selectedColor ?? '-'}   Size: ${item.selectedSize ?? '-'}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.add, size: 16),
                          onTap: () =>
                              cart.updateQuantity(item, item.quantity + 1),
                        ),
                        Text("${item.quantity}"),
                        GestureDetector(
                          child: const Icon(Icons.remove, size: 16),
                          onTap: () =>
                              cart.updateQuantity(item, item.quantity - 1),
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
        const SizedBox(width: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
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
      padding: const EdgeInsets.all(12),

      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            "Promocode applied",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF7F9FA),
        borderRadius: BorderRadius.circular(8),
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
          const Divider(height: 30),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: AppTheme.primaryColor,
                  )
                : Theme.of(context).textTheme.bodyMedium,
          ),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
