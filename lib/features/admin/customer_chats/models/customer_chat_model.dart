import 'package:disan/features/chat/models/message_model.dart';

class CustomerChatModel {
  final String id;
  final String customerId;
  final String shopId;
  CustomerModel? customer;
  final List<ChatMessage>? messages;

  CustomerChatModel(
      {required this.id,required this.shopId, required this.customerId, this.messages, this.customer});

  factory CustomerChatModel.fromJson(Map<String, dynamic> json) {
    return CustomerChatModel(
      id: json['id'].toString(),
      shopId: json['shop_id'].toString(),
      customerId: json['customer_id']?.toString() ?? '',
      messages: (json['messages'] as List<dynamic>?)
          ?.map((messageJson) => ChatMessage.fromJson(messageJson))
          .toList(),
      customer:
          json['user'] != null ? CustomerModel.fromJson(json['user']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shop_id': shopId,
      'customer_id': customerId,
      'user': customer?.toJson(),
      'messages': messages?.map((m) => m.toJson()).toList(),
    };
  }
}

class CustomerModel {
  final String name;
  final String image;

  CustomerModel({required this.name, required this.image});
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['full_name'],
      image: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'full_name': name, 'profile_picture': image};
  }
}
