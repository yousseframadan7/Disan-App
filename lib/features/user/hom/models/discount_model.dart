class DiscountModel {
  final String image;
  final String title;
  final String description;
  final String shopName;
  final String offerType;
  final int discountPercent;
  DiscountModel(
      {required this.image,
      required this.title,
      required this.description,
      required this.shopName,
      required this.offerType,
      required this.discountPercent});
  factory DiscountModel.fromJson(Map<String, dynamic> json) {
    return DiscountModel(
        image: json['image'],
        title: json['title'],
        description: json['description'],
        shopName: json['shop_name'],
        offerType: json['offer_type'],
        discountPercent: json['discount_percent']);
  }
  toJson() => {
        'image': image,
        'title': title,
        'description': description,
        'shop_name': shopName,
        'offer_type': offerType,
        'discount_percent': discountPercent
      };
  @override
  String toString() {
    // TODO: implement toString
    return 'DiscountModel{image: $image, title: $title, description: $description, shopName: $shopName, offerType: $offerType, discountPercent: $discountPercent}';
  }
}
