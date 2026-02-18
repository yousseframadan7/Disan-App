import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:disan/features/user/home/models/comment_model.dart';
import 'package:disan/features/user/home/models/post_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'post_state.dart';

class PostCubit extends Cubit<GetPostsState> {
  PostCubit() : super(GetPostsInitial()) {
    getPosts();
  }

  List<PostModel> posts = [];
  List<CommentModel> comments = [];
  final supabase = getIt<SupabaseClient>();
  StreamSubscription? _commentSubscription;

  Future<void> getPosts({int page = 0}) async {
    try {
      emit(GetPostsLoading());
      final userId = supabase.auth.currentUser?.id;

      final response = await supabase.rpc(
        'get_posts_with_likes_and_comments',
        params: {'_user_id': userId, '_limit': 10, '_offset': page * 10},
      );
      log("${response.toString()} yousssef");

      final List<PostModel> tempPosts = (response as List).map((e) {
        return PostModel.fromJson(e).copyWith(
          likesNum: e['likes_count'] ?? 0,
          likedByMe: e['liked_by_me'] ?? false,
          commentsCount: e['comments_count'] ?? 0,
        );
      }).toList();

      // Fetch user data for posts
      final List<PostModel> updatedPosts = await Future.wait(
        tempPosts.map((post) async {
          try {
            final userResponse = await supabase
                .from('users')
                .select()
                .eq('id', post.shopId)
                .single();
            return post.copyWith(user: UserModel.fromJson(userResponse));
          } catch (e) {
            return post;
          }
        }),
      );

      posts = updatedPosts;
      emit(GetPostsSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetPostsFailure(error: e.toString()));
    }
  }

  Future<void> toggleLike(String postId) async {
    try {
      final response = await supabase.rpc(
        'toggle_like_post',
        params: {'_post_id': postId},
      );
      final bool isLikedNow = response as bool;
      posts = posts.map((p) {
        if (p.id == postId) {
          final newLikes = (p.likesNum) + (isLikedNow ? 1 : -1);
          return p.copyWith(likesNum: newLikes, likedByMe: isLikedNow);
        }
        return p;
      }).toList();
      emit(GetPostsSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddLikeFailure(error: e.toString()));
    }
  }

  Future<void> addComment({
    required String postId,
    required String comment,
  }) async {
    try {
      await supabase.from('comments').insert({
        'target_id': postId,
        'user_id': supabase.auth.currentUser!.id,
        'target_type': 'post',
        'commect': comment,
      });
      // Update comments count for the post
      posts = posts.map((p) {
        if (p.id == postId) {
          return p.copyWith(commentsCount: p.commentsCount + 1);
        }
        return p;
      }).toList();
      emit(AddCommentSuccess());
      emit(GetPostsSuccess()); // Update UI with new comments count
    } catch (e) {
      log(e.toString());
      emit(AddCommentFailure(error: e.toString()));
    }
  }

  void streamComments(String postId) {
    // Cancel any existing subscription
    _commentSubscription?.cancel();

    emit(GetCommentsLoading());

    // Subscribe to real-time comments
    _commentSubscription = supabase
        .from('comments')
        .stream(primaryKey: ['id'])
        .eq('target_id', postId)
        .listen((List<Map<String, dynamic>> data) async {
          try {
            // Fetch user data for each comment
            final List<CommentModel> tempComments = data
                .map((e) => CommentModel.fromJson(e))
                .toList();
            final List<CommentModel> updatedComments = await Future.wait(
              tempComments.map((comment) async {
                try {
                  final userResponse = await supabase
                      .from('users')
                      .select()
                      .eq('id', comment.userId)
                      .single();
                  return comment.copyWith(
                    user: UserModel.fromJson(userResponse),
                  );
                } catch (e) {
                  return comment;
                }
              }),
            );

            comments = updatedComments;
            emit(GetCommentsSuccess());
          } catch (e) {
            log(e.toString());
            emit(GetCommentsFailure(error: e.toString()));
          }
        });
  }

  Future<void> deletePost(String postId) async {
    try {
      final currentUserId = supabase.auth.currentUser?.id;

      final post = posts.firstWhere((element) => element.id == postId);

      if (post.shopId != currentUserId) {
        emit(GetPostsFailure(error: "You can't delete this post"));
        return;
      }

      await supabase.from('blogs').delete().eq('id', postId);

      posts.removeWhere((element) => element.id == postId);

      emit(GetPostsSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetPostsFailure(error: e.toString()));
    }
  }

  Future<void> sharePost(PostModel originalPost) async {
    try {
      emit(GetPostsLoading());
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) return;

      String originalName = originalPost.user?.name ?? "";
      String originalImage = originalPost.user?.image ?? "";
      String content = originalPost.content;
      String? image = originalPost.image;

      /// لو البوست دا share اصلا نفكّه
      if (content.startsWith("__shared__")) {
        final parts = content.split("__");

        if (parts.length >= 6) {
          originalName = parts[2];
          originalImage = parts[3];
          content = parts[4];
          image = parts[5].isEmpty ? null : parts[5];
        }
      }

      final sharedContent =
          "__shared__${originalName}__${originalImage}__${content}__${image ?? ""}";

      await supabase.from("blogs").insert({
        "content": sharedContent,
        "image": image,
        "shop_id": currentUser.id,
        "created_at": DateTime.now().toIso8601String(),
      });

      await getPosts();
    } catch (e) {
      log(e.toString());
      emit(GetPostsFailure(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _commentSubscription?.cancel();
    return super.close();
  }
}
