part of 'get_order_items_cubit.dart';

@immutable
sealed class GetOrderItemsState {}

final class GetOrderItemsInitial extends GetOrderItemsState {}
final class GetOrderItemsLoading extends GetOrderItemsState {}
final class GetOrderItemsSuccess extends GetOrderItemsState {}
final class GetOrderItemsFailure extends GetOrderItemsState {
  final String message;
  GetOrderItemsFailure({required this.message});
}
