class ProductModel {
  final String id;
  final String shopId;
  final String categoryId;
  final String name;
  final String shopName;
  final String image;
  final String description;
  final double price;
  final String category;
  final int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.shopName,
    required this.stock,
    required this.shopId,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image_url'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'] ?? "",
      shopName: json['shop_name'] ?? "Unknown",
      stock: json['stock'] ?? "",
      shopId: json['shop_id'] ?? "",
      categoryId: json['category_id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': image,
      'description': description,
      'price': price,
      'category': category,
      'stock': stock,
      'shop_id': shopId,
      'category_id': categoryId,
      'shop_name': shopName
    };
  }
}
