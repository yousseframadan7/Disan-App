part of 'get_shop_details_cubit.dart';

@immutable
sealed class GetShopDetailsState {}

final class GetShopDetailsInitial extends GetShopDetailsState {}

final class GetShopDetailsSuccess extends GetShopDetailsState {}

final class GetShopDetailsLoading extends GetShopDetailsState {}

final class EmptyShopProducts extends GetShopDetailsState {}

final class GetShopDetailsFailure extends GetShopDetailsState {
  final String message;
  GetShopDetailsFailure({required this.message});
}
