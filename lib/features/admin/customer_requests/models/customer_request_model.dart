import 'package:disan/features/admin/customer_requests_details/models/order_item_model.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';

class CustomerRequestModel {
  final String id;
  final String customerId;
  final double totalAmount;
  final String? status;
  final String? createdAt;
  UserModel? user;
  List<OrderItemModel>? orders;

  CustomerRequestModel({
    required this.id,
    required this.customerId,
    required this.totalAmount,
    this.status,
    this.createdAt,
    this.user,
    this.orders,
  });
  factory CustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerRequestModel(
      id: json['id'],
      customerId: json['customer_id'],
      totalAmount: double.parse(json['total_amount'].toString()),
      status: json['status'],
      createdAt: json['created_at'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      orders: json['orders']?.map<OrderItemModel>((e) => OrderItemModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'total_amount': totalAmount,
        'status': status,
        'created_at': createdAt,
        'user': user?.toJson(),
        'orders': orders?.map((e) => e.toJson()).toList(),
      };
}
