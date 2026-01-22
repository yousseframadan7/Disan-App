import 'package:disan/features/user/shop_products/models/product_model.dart';

class OrderItemModel {
  final String id;
  final String orderId;
  final String productId;
  final int quantity;
  final double priceAtTime;
  ProductModel? product;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.priceAtTime,
    this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      priceAtTime: double.parse(json['price_at_time'].toString()),
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'quantity': quantity,
        'price_at_time': priceAtTime,
        'product': product?.toJson(),
      };
}
