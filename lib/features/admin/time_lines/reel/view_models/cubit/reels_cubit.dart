import 'dart:async';
import 'dart:developer';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/time_lines/reel/models/reel_model.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:disan/features/user/home/models/comment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';

enum ReelStatus {
  initial,
  loading,
  playing,
  paused,
  error,
  likeUpdated,
  commentAdded,
  commentsLoading,
  commentsLoaded,
  commentsError,
}

class ReelCubit extends Cubit<ReelStatus> {
  List<ReelModel> reels;
  int currentIndex;
  VideoPlayerController? videoController;
  final SupabaseClient supabase = getIt<SupabaseClient>();
  StreamSubscription? _commentSubscription;
  StreamSubscription? _likeSubscription;
  List<CommentModel> comments = [];

  ReelCubit({required this.reels, this.currentIndex = 0})
      : super(ReelStatus.initial) {
    if (reels.isNotEmpty) {
      initializeVideo(index: currentIndex);
    }
  }

  /// Fetch reels with like and comment counts from Supabase
  Future<void> fetchReels({int limit = 10, int offset = 0}) async {
    try {
      emit(ReelStatus.loading);
      final response = await _fetchWithRetry(() async => await supabase.rpc(
            'get_reels_with_likes_and_comments',
            params: {
              '_user_id': supabase.auth.currentUser!.id,
              '_limit': limit,
              '_offset': offset,
            },
          ));
      reels = (response as List<dynamic>)
          .map((e) => ReelModel.fromJson(e))
          .toList();
      if (reels.isNotEmpty) {
        currentIndex = 0;
        await initializeVideo(index: currentIndex);
      } else {
        emit(ReelStatus.error);
      }
    } catch (e) {
      log('Error fetching reels: $e');
      emit(ReelStatus.error);
    }
  }

  /// Initialize video for a specific reel index
  Future<void> initializeVideo({required int index}) async {
    if (index < 0 || index >= reels.length) return;

    currentIndex = index;
    comments =
        []; // Clear comments list to avoid showing comments from previous reel
    emit(ReelStatus.loading);

    try {
      await videoController?.pause();
      await videoController?.dispose();

      videoController = VideoPlayerController.networkUrl(
        Uri.parse(reels[currentIndex].videoUrl),
      );

      await videoController!.initialize();
      await videoController!.play();

      // Start streaming likes and comments for the current reel
      streamLikes(reels[currentIndex].id);
      streamComments(reels[currentIndex].id);

      emit(ReelStatus.playing);
    } catch (e) {
      log('Error initializing video for reel ${reels[currentIndex].id}: $e');
      emit(ReelStatus.error);
    }
  }

  /// Navigate to the next reel
  void nextReel() {
    if (currentIndex + 1 < reels.length) {
      initializeVideo(index: currentIndex + 1);
    }
  }

  /// Navigate to the previous reel
  void previousReel() {
    if (currentIndex - 1 >= 0) {
      initializeVideo(index: currentIndex - 1);
    }
  }

  /// Pause the current video
  Future<void> pauseVideo() async {
    if (videoController != null && videoController!.value.isPlaying) {
      await videoController!.pause();
      emit(ReelStatus.paused);
    }
  }

  /// Resume playing the current video
  Future<void> resumeVideo() async {
    if (videoController != null && !videoController!.value.isPlaying) {
      await videoController!.play();
      emit(ReelStatus.playing);
    }
  }

  /// Dispose video controller
  void disposeController() async {
    if (videoController != null) {
      await videoController!.pause();
      await videoController!.dispose();
      videoController = null;
    }
  }

  /// Toggle like for a reel
  Future<void> toggleLike(String reelId) async {
    try {
      final response = await _fetchWithRetry(() async => await supabase.rpc(
            'toggle_like_reel',
            params: {'_reel_id': reelId},
          ));
      final bool isLikedNow = response as bool;

      // Fetch the latest like count
      final likeCountResponse = await _fetchWithRetry(() async => await supabase
          .from('likes')
          .select('id')
          .eq('target_type', 'reel')
          .eq('target_id', reelId)
          .count());

      // ابحث عن الـ index الصحيح بناءً على reelId بدلاً من currentIndex
      // عشان لو اليوزر غير الريل، يتحدث الريل الصحيح
      final index = reels.indexWhere((r) => r.id == reelId);
      if (index != -1) {
        reels[index] = reels[index].copyWith(
          likesNum: likeCountResponse.count,
          likedByMe: isLikedNow,
        );
        log('Like updated for reel $reelId: ${reels[index].likesNum}, likedByMe: ${reels[index].likedByMe}');
      } else {
        log('Reel with ID $reelId not found in the list');
      }

      emit(ReelStatus.likeUpdated);
    } catch (e) {
      log('Error toggling like for reel $reelId: $e');
      emit(ReelStatus.error);
    }
  }

  /// Add a comment to a reel
  Future<void> addComment(
      {required String reelId, required String comment}) async {
    try {
      await _fetchWithRetry(() async => await supabase.from('comments').insert({
            'target_id': reelId,
            'user_id': supabase.auth.currentUser!.id,
            'target_type': 'reel',
            'commect': comment,
          }));

      // Fetch the latest comment count
      final commentCountResponse = await _fetchWithRetry(() async =>
          await supabase
              .from('comments')
              .select('id')
              .eq('target_type', 'reel')
              .eq('target_id', reelId)
              .count());

      reels[currentIndex] = reels[currentIndex].copyWith(
        commentsCount: commentCountResponse.count,
      );
      emit(ReelStatus.commentAdded);
      log('Comment added for reel $reelId: ${reels[currentIndex].commentsCount}');
    } catch (e) {
      log('Error adding comment for reel $reelId: $e');
      emit(ReelStatus.error);
    }
  }

  /// Stream comments for a reel in real-time
  void streamComments(String reelId) {
    _commentSubscription?.cancel();
    comments = []; // Clear comments list before starting new stream
    emit(ReelStatus.commentsLoading);

    _commentSubscription = supabase
        .from('comments')
        .stream(primaryKey: ['id'])
        .eq('target_id', reelId)
        .order('created_at', ascending: false)
        .listen((List<Map<String, dynamic>> data) async {
          try {
            final List<CommentModel> tempComments =
                data.map((e) => CommentModel.fromJson(e)).toList();

            final List<CommentModel> updatedComments = await Future.wait(
              tempComments.map((comment) async {
                try {
                  final userResponse = await supabase
                      .from('users')
                      .select()
                      .eq('id', comment.userId)
                      .single();
                  return comment.copyWith(
                      user: UserModel.fromJson(userResponse));
                } catch (e) {
                  log('Error fetching user for comment on reel $reelId: $e');
                  return comment;
                }
              }),
            );

            comments = updatedComments;
            reels[currentIndex] = reels[currentIndex].copyWith(
              commentsCount: comments.length,
            );
            emit(ReelStatus.commentsLoaded);
            log('Comments loaded for reel $reelId: ${comments.length}, comments: ${comments.map((c) => c.content).toList()}');
          } catch (e) {
            log('Error streaming comments for reel $reelId: $e');
            emit(ReelStatus.commentsError);
          }
        });
  }

  /// Stream likes for a reel in real-time
  void streamLikes(String reelId) {
    _likeSubscription?.cancel();

    _likeSubscription = supabase
        .from('likes')
        .stream(primaryKey: ['id'])
        .eq('target_id', reelId)
        .listen((List<Map<String, dynamic>> data) async {
          try {
            final likesCount = data.length;
            final likedByMe = data.any(
                (like) => like['user_id'] == supabase.auth.currentUser!.id);

            reels[currentIndex] = reels[currentIndex].copyWith(
              likesNum: likesCount,
              likedByMe: likedByMe,
            );
            emit(ReelStatus.likeUpdated);
            log('Likes streamed for reel $reelId: $likesCount, likedByMe: $likedByMe');
          } catch (e) {
            log('Error streaming likes for reel $reelId: $e');
            emit(ReelStatus.error);
          }
        });
  }

  /// Retry logic for network requests
  Future<T> _fetchWithRetry<T>(Future<T> Function() operation,
      {int retries = 3}) async {
    for (int i = 0; i < retries; i++) {
      try {
        return await operation();
      } catch (e) {
        if (i == retries - 1) {
          log('Failed after $retries attempts: $e');
          rethrow;
        }
        await Future.delayed(Duration(seconds: 1));
      }
    }
    throw Exception('Operation failed after $retries retries');
  }

  @override
  Future<void> close() async {
    disposeController();
    _commentSubscription?.cancel();
    _likeSubscription?.cancel();
    return super.close();
  }
}
