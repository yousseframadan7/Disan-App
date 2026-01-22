import 'package:disan/features/admin/time_lines/story/models/user_model.dart';

class LikeModel {
  final String targetId;
  final String targetType;
  final String userId;
  final UserModel? userModel;

  LikeModel({
    required this.targetId,
    required this.targetType,
    required this.userId,
    this.userModel,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      targetType: json['target_type'] as String,
      targetId: json['target_id'] as String,
      userId: json['user_id'] as String,
      userModel: json['users'] != null ? UserModel.fromJson(json['users']) : null,
    );
  }
}
