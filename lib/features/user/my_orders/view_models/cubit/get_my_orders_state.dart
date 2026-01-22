part of 'get_my_orders_cubit.dart';

@immutable
sealed class GetMyOrdersState {}

final class GetMyOrdersInitial extends GetMyOrdersState {}
final class GetMyOrdersLoading extends GetMyOrdersState {}
final class GetMyOrdersSuccess extends GetMyOrdersState {}
final class GetMyOrdersFailure extends GetMyOrdersState {
  final String message;
  GetMyOrdersFailure({required this.message});
}
final class EmptyOrders extends GetMyOrdersState {}
