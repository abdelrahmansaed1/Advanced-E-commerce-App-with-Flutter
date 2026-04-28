class UserModel {
  final String customerToken;
  final String name;
  final String email;
  final String userId;
  final String countryCode;
  final String telephone;
  final int newsletter;
  final String dateOfBirth;

  UserModel({
    required this.customerToken,
    required this.name,
    required this.email,
    required this.userId,
    required this.countryCode,
    required this.telephone,
    required this.newsletter,
    required this.dateOfBirth,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    customerToken: json['customer_token'] ?? '',
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    userId: json['user_id'] ?? '',
    countryCode: json['country_code'] ?? '',
    telephone: json['telephone'] ?? '',
    newsletter: json['newsletter'] ?? 0,
    dateOfBirth: json['date_of_birth'] ?? '',
  );
}
