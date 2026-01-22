part of 'customer_sign_up_cubit.dart';

@immutable
sealed class CustomerSignUpState {}

final class SignUpInitial extends CustomerSignUpState {}

final class SignUpLoading extends CustomerSignUpState {}

final class SignUpSuccess extends CustomerSignUpState {}

final class SignUpFailure extends CustomerSignUpState {
  final String message;
  SignUpFailure({required this.message});
}
// pick image status
final class PickImageLoading extends CustomerSignUpState {}

final class PickImageSuccess extends CustomerSignUpState {}

final class PickImageFailure extends CustomerSignUpState {
  final String message;
  PickImageFailure({required this.message});
}
// get categories status
final class GetCategoriesLoading extends CustomerSignUpState {}

final class GetCategoriesSuccess extends CustomerSignUpState {}

final class GetCategoriesFailure extends CustomerSignUpState {
  final String message;
  GetCategoriesFailure({required this.message});
}

final class GetCategoriesEmpty extends CustomerSignUpState {}