  import 'package:disan/features/admin/time_lines/story/models/user_model.dart';

  enum MediaType { image, video, text }

  class StoryModel {
    final String? url;
    final String content;
    final MediaType type;
    final Duration duration;
    final UserModel? user;
    final String shopId;
    StoryModel({
      this.url,
      required this.content,
      required this.type,
      required this.duration,
      this.user,
      required this.shopId,
    });

    factory StoryModel.fromJson(Map<String, dynamic> json) {
      final url = json['media_url'] as String?;
      final mediaType =
          url != null ? _getMediaTypeFromExtension(url) : MediaType.text;

      return StoryModel(
        url: url,
        content: json['media_text'] ?? '',
        type: mediaType,
        duration: Duration(seconds: 5),
        user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
        shopId: json['shop_id'],
      );
    }
    
    static MediaType _getMediaTypeFromExtension(String url) {
      final lowerUrl = url.toLowerCase();

      if (lowerUrl.endsWith('.jpg') ||
          lowerUrl.endsWith('.jpeg') ||
          lowerUrl.endsWith('.png') ||
          lowerUrl.endsWith('.gif') ||
          lowerUrl.endsWith('.webp')) {
        return MediaType.image;
      }

      if (lowerUrl.endsWith('.mp4') ||
          lowerUrl.endsWith('.mov') ||
          lowerUrl.endsWith('.avi') ||
          lowerUrl.endsWith('.mkv')) {
        return MediaType.video;
      }

      return MediaType.text;
    }

    Map<String, dynamic> toJson() {
      return {
        'media_url': url,
        'media_text': content,
        'media_duration': duration.inSeconds.toString(),
        'user': user?.toJson(),
      };
    }

    StoryModel copyWith({
      String? url,
      String? content,
      MediaType? type,
      Duration? duration,
      UserModel? user,
      String? shopId,
    }) {
      return StoryModel(
        url: url ?? this.url,
        content: content ?? this.content,
        type: type ?? this.type,
        duration: duration ?? this.duration,
        user: user ?? this.user,
        shopId: shopId ?? this.shopId,
      );
    }

    @override
    String toString() {
      return 'StoryModel(url: $url, content: $content, type: $type, duration: $duration, user: $user)';
    }
  }
