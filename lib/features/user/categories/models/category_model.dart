class CategoryModel {
  final String name;
  final String image;
  final String description;
  final String id;

  CategoryModel(
      {required this.name,
      required this.image,
      required this.description,
      required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        name: json['name'],
        image: json['image_url'],
        description: json['description'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': image,
      'description': description,
      'id': id
    };
  }
}
