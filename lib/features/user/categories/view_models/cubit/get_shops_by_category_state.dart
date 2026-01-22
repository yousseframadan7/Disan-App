part of 'get_shops_by_category_cubit.dart';

@immutable
sealed class GetShopsByCategoryState {}

final class GetShopsByCategoryInitial extends GetShopsByCategoryState {}
final class GetShopsByCategoryLoading extends GetShopsByCategoryState {}
final class GetShopsByCategorySuccess extends GetShopsByCategoryState {}
final class GetShopsByCategoryFailure extends GetShopsByCategoryState {
  final String message;
  GetShopsByCategoryFailure({required this.message});
}
final class EmptyShops extends GetShopsByCategoryState {}
