part of 'order_product_cubit.dart';

@immutable
sealed class OrderProductState {}

final class OrderProductInitial extends OrderProductState {}

final class OrderProductLoading extends OrderProductState {}

final class OrderProductSuccess extends OrderProductState {}

final class OrderProductFailure extends OrderProductState {
  final String message;
  OrderProductFailure({required this.message});
}

final class GetMyPrudctProduct extends OrderProductState {}

final class UpdateQuantity extends OrderProductState {}
final class DeleteProduct extends OrderProductState {}
