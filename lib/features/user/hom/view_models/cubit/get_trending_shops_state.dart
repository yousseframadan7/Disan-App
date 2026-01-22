part of 'get_trending_shops_cubit.dart';

@immutable
sealed class GetTrendingShopsState {}

final class GetTrendingShopsInitial extends GetTrendingShopsState {}
final class GetTrendingShopsLoading extends GetTrendingShopsState {}
final class GetTrendingShopsSuccess extends GetTrendingShopsState {}
final class GetTrendingShopsFailure extends GetTrendingShopsState {
  final String message;
  GetTrendingShopsFailure({required this.message});
}

final class EmptyTrendingShops extends GetTrendingShopsState {}
