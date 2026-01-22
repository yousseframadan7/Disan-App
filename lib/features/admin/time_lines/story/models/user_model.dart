class UserModel {
  final String id;
  final String name;
  final String image;
  final String email;
  final String role;
  final String phone;
  List<String>? tokens;

  UserModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    required this.role,
    required this.phone,
    this.tokens,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['full_name'] ?? '',
      image: json['profile_picture'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      phone: json['phone'] ?? '',
      tokens: json['token'] is List
          ? List<String>.from(json['token'])
          : json['token'] is String
              ? [json['token']]
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'profile_picture': image,
      'email': email,
      'role': role,
      'phone': phone,
      'token': tokens,
    };
  }
}
