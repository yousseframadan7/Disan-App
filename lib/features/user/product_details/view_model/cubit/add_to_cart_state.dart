part of 'add_to_cart_cubit.dart';

@immutable
sealed class AddToCartState {}

final class AddToCartInitial extends AddToCartState {}

//
final class UpdateQuantity extends AddToCartState {}

//
final class AddToCartLoading extends AddToCartState {}

final class AddToCartSuccess extends AddToCartState {}

final class AddToCartFailure extends AddToCartState {
  final String message;
  AddToCartFailure({required this.message});
}

// ignore: must_be_immutable
final class ProductExistsInCart extends AddToCartState {
  String message = 'Product already exists in cart.';
}

//
final class RemoveFromCartLoading extends AddToCartState {}

final class RemoveFromCartSuccess extends AddToCartState {}

final class RemoveFromCartFailure extends AddToCartState {
  final String message;
  RemoveFromCartFailure({required this.message});
}
//
final class UpdateProductExistsInCart extends AddToCartState {}
//
final class DeleteProductLoading extends AddToCartState {}

final class DeleteProductSuccess extends AddToCartState {}

final class DeleteProductFailure extends AddToCartState {
  final String message;
  DeleteProductFailure({required this.message});
}
//
final class UpdateProductLoading extends AddToCartState {}

final class UpdateProductSuccess extends AddToCartState {}

final class UpdateProductFailure extends AddToCartState {
  final String message;
  UpdateProductFailure({required this.message});
}
