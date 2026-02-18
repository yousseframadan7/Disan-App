import 'package:disan/features/admin/time_lines/story/models/user_model.dart';

class PostModel {
  final String content;
  final String? image;
  final String id;
  final String shopId;
  final DateTime createdAt;
  final UserModel? user;

  final int commentsCount; // عدد الكومنتات
  final int likesNum; // عدد اللايكات
  final bool likedByMe; // هل أنا عامل لايك

  PostModel({
    required this.content,
    this.image,
    required this.id,
    required this.shopId,
    required this.createdAt,
    this.user,
    this.likesNum = 0,
    this.likedByMe = false,
    this.commentsCount = 0,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      content: json['content'],
      image: json['image'],
      id: json['id'],
      shopId: json['shop_id'],
      createdAt: DateTime.parse(json['created_at']),
      commentsCount: json['comments_count'] ?? 0, // جديد
    );
  }

  Map<String, dynamic> toJson() => {
    'content': content,
    'image': image,
    'id': id,
    'shop_id': shopId,
    'created_at': createdAt.toIso8601String(),
    'comments_count': commentsCount,
    'likes_num': likesNum,
  };

  PostModel copyWith({
    String? content,
    String? image,
    String? id,
    String? shopId,
    DateTime? createdAt,
    UserModel? user,
    int? likesNum,
    bool? likedByMe,
    int? commentsCount,
  }) {
    return PostModel(
      content: content ?? this.content,
      image: image ?? this.image,
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      likesNum: likesNum ?? this.likesNum,
      likedByMe: likedByMe ?? this.likedByMe,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }
}
