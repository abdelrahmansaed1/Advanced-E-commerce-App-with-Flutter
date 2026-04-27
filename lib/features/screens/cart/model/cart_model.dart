// lib/models/cart_model.dart

class CartModel {
  final String id;
  final String name;
  int quantity;
  final String price;
  final String? image;
  final String? description;

  CartModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    this.image,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 1,
      price: map['price'] ?? '0',
      image: map['image'],
      description: map['description'],
    );
  }
}
