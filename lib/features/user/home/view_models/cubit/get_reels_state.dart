part of 'get_reels_cubit.dart';

sealed class GetReelsState {}

final class GetReelsInitial extends GetReelsState {}

final class GetReelsLoading extends GetReelsInitial {}

final class GetReelsSuccess extends GetReelsInitial {}

final class GetReelsFailure extends GetReelsInitial {
  final String error;

  GetReelsFailure({required this.error});
}
