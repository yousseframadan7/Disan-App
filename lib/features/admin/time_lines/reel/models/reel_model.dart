import 'package:disan/features/admin/time_lines/story/models/user_model.dart';

class ReelModel { 
  final String id;
  final String videoUrl;
  final UserModel? userModel;
  final String? caption;
  final String shopId;

  // الحقول الجديدة
  final int likesNum;
  final bool likedByMe;
  final int commentsCount;
  UserModel? user;

  ReelModel({
    this.user,
    required this.id,
    required this.videoUrl,
    this.userModel,
    this.caption,
    required this.shopId,
    this.likesNum = 0, // default موجود أصلاً
    this.likedByMe = false, // default موجود أصلاً
    this.commentsCount = 0, // default موجود أصلاً
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id']?.toString() ?? '',
      videoUrl: json['video_url']?.toString() ?? '',
      userModel: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      caption: json['caption']?.toString() ?? 'No Caption',
      shopId: json['shop_id']?.toString() ?? '',
      likesNum: json['likes_count'] ?? 0,
      likedByMe: json['liked_by_me'] ?? false,
      commentsCount: json['comments_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'video_url': videoUrl,
      'user': userModel?.toJson(),
      'caption': caption,
      'shop_id': shopId,
      'likes_count': likesNum,
      'liked_by_me': likedByMe,
      'comments_count': commentsCount,
    };
  }

  ReelModel copyWith({
    String? id,
    String? videoUrl,
    UserModel? userModel,
    String? caption,
    String? shopId,
    int? likesNum,
    bool? likedByMe,
    int? commentsCount,
    UserModel? user,
  }) {
    return ReelModel(
      id: id ?? this.id,
      videoUrl: videoUrl ?? this.videoUrl,
      userModel: userModel ?? this.userModel,
      caption: caption ?? this.caption,
      shopId: shopId ?? this.shopId,
      likesNum: likesNum ?? this.likesNum,
      likedByMe: likedByMe ?? this.likedByMe,
      commentsCount: commentsCount ?? this.commentsCount,
      user: user ?? this.user,
    );
  }

}