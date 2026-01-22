import 'package:disan/features/admin/time_lines/story/models/user_model.dart';

class CommentModel {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final UserModel? user;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      postId: json['target_id'] as String,
      userId: json['user_id'] as String,
      content: json['commect'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      user: json['users'] != null ? UserModel.fromJson(json['users']) : null,
    );
  }

  CommentModel copyWith({
    String? id,
    String? postId,
    String? userId,
    String? content,
    DateTime? createdAt,
    UserModel? user,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }
}
