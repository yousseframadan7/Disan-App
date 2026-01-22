part of 'get_shop_products_cubit.dart';

@immutable
sealed class GetShopProductsState {}

final class GetShopProductsInitial extends GetShopProductsState {}
final class GetShopProductsLoading extends GetShopProductsState {}
final class GetShopProductsSuccess extends GetShopProductsState {}
final class EmptyShopProducts extends GetShopProductsState {}
final class GetShopProductsFailure extends GetShopProductsState {
  final String message;
  GetShopProductsFailure({required this.message});
}
