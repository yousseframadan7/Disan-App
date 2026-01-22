part of 'post_cubit.dart';

@immutable
abstract class GetPostsState {}

class GetPostsInitial extends GetPostsState {}

class GetPostsLoading extends GetPostsState {}

class GetPostsSuccess extends GetPostsState {}

class GetPostsFailure extends GetPostsState {
  final String error;
  GetPostsFailure({required this.error});
}

class AddLikeFailure extends GetPostsState {
  final String error;
  AddLikeFailure({required this.error});
}

class AddCommentSuccess extends GetPostsState {}

class AddCommentFailure extends GetPostsState {
  final String error;
  AddCommentFailure({required this.error});
}

class GetCommentsLoading extends GetPostsState {}

class GetCommentsSuccess extends GetPostsState {}

class GetCommentsFailure extends GetPostsState {
  final String error;
  GetCommentsFailure({required this.error});
}