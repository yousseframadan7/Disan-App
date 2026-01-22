import 'package:disan/features/user/shop_products/models/product_model.dart';

class ShopModel {
  final String id;
  final String name;
  final String image;
  final String? description;
  final String? address;
  final String? phone;
  final String? category;
  final String? rating;
  final List<ProductModel> products;

  ShopModel({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    required this.address,
    this.phone,
    this.rating,
    required this.category,
    this.products = const [],
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] ?? '',
      name: json['shop_name'] ?? '',
      category: json['category_name'] ?? 'Uncategorized',
      rating: json['rating']?.toString() ?? '4.5',
      image: json['profile_picture'] ?? '',
      description: json['description'] ??
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      address: json['address'] ?? 'Cairo, Egypt',
      phone: json['phone'] ?? '+20 0000000000',
      products: (json['products'] as List<dynamic>?)
              ?.map((item) => ProductModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'address': address,
      'phone': phone,
      'category': category,
      'rating': rating,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  copyWith(
      {String? id,
      String? name,
      String? image,
      String? description,
      String? address,
      String? phone,
      String? category,
      String? rating,
      List<ProductModel>? products}) {
    return ShopModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      products: products ?? this.products,
    );
  }
}
