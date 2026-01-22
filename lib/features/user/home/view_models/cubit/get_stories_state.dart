part of 'get_stories_cubit.dart';

@immutable
sealed class GetStoriesState {}

final class GetStoriesInitial extends GetStoriesState {}
final class GetStoriesLoading extends GetStoriesState {}
final class GetStoriesSuccess extends GetStoriesState {}
final class GetStoriesFailure extends GetStoriesState {
  final String error;

  GetStoriesFailure({required this.error});
}
