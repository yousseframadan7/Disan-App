part of 'shop_sign_up_cubit.dart';

@immutable
sealed class ShopSignUpState {}

final class ShopSignUpInitial extends ShopSignUpState {}

final class ShopSignUpLoading extends ShopSignUpState {}

final class ShopSignUpSuccess extends ShopSignUpState {}

final class ShopSignUpFailure extends ShopSignUpState {
  final String message;
  ShopSignUpFailure({required this.message});
}
// pick image status
final class PickImageLoading extends ShopSignUpState {}

final class PickImageSuccess extends ShopSignUpState {}

final class PickImageFailure extends ShopSignUpState {
  final String message;
  PickImageFailure({required this.message});
}
// get categories status
final class GetCategoriesLoading extends ShopSignUpState {}

final class GetCategoriesSuccess extends ShopSignUpState {}

final class GetCategoriesFailure extends ShopSignUpState {
  final String message;
  GetCategoriesFailure({required this.message});
}

final class GetCategoriesEmpty extends ShopSignUpState {}