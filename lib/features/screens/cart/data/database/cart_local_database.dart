// import 'package:e_commerce_project/core/helper/db_helpers.dart';

// abstract class CartLocalDatabase {
//   Future<void> addToCart(Map<String, dynamic> product);
//   Future<List<Map<String, dynamic>>> getCartItems();
//   Future<void> updateCartItem(Map<String, dynamic> product);
//   Future<void> removeFromCart(String productId);
//   Future<void> clearCart();
// }

// class CartLocalDatabaseImpl extends CartLocalDatabase {
//   final DbHelper dbHelper;
//   CartLocalDatabaseImpl(this.dbHelper);

//   @override
//   Future<void> addToCart(Map<String, dynamic> product) async {
//     final database = await dbHelper.db;
//     await database.insert(dbHelper.cart, values);
//   }

//   @override
//   Future<List<Map<String, dynamic>>> getCartItems() {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> removeFromCart(String productId) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> updateCartItem(Map<String, dynamic> product) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> clearCart() {
//     throw UnimplementedError();
//   }
// }
