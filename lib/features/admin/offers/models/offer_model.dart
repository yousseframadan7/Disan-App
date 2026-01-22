
class OfferModel {
  final String id;
  final String productId;
  final String title;
  final String? description;
  final String offerType; // discount, buyXgetYSame, buyXgetYDifferent, gift
  final int? discountPercent;
  final int? buyQuantity;
  final int? getQuantity;
  final String? imageUrl;
  final DateTime endDate;
  final DateTime? createdAt;

  const OfferModel({
    required this.id,
    required this.productId,
    required this.title,
    this.description,
    required this.offerType,
    this.discountPercent,
    this.buyQuantity,
    this.getQuantity,
    this.imageUrl,
    required this.endDate,
    this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      productId: json['product_id'],
      title: json['title'],
      description: json['description'],
      offerType: json['offer_type'],
      discountPercent: json['discount_percent'],
      buyQuantity: json['buy_quantity'],
      getQuantity: json['get_quantity'],
      imageUrl: json['image_url'],
      endDate: DateTime.parse(json['end_date']),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'title': title,
      'description': description,
      'offer_type': offerType,
      'discount_percent': discountPercent,
      'buy_quantity': buyQuantity,
      'get_quantity': getQuantity,
      'image_url': imageUrl,
      'end_date': endDate.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        title,
        description,
        offerType,
        discountPercent,
        buyQuantity,
        getQuantity,
        imageUrl,
        endDate,
        createdAt,
      ];
}
