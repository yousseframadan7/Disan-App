part of 'add_post_cubit.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class AddPostLoading extends AddPostState {}

final class AddPostSuccess extends AddPostState {}

final class AddPostFailure extends AddPostState {
  final String error;
  AddPostFailure({required this.error});
}

final class AddPostImagePicked extends AddPostState {}

final class AddPostImageRemoved extends AddPostState {}
