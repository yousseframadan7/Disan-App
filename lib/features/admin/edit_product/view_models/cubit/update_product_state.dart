part of 'update_product_cubit.dart';

@immutable
sealed class UpdateProductState {}

final class UpdateProductInitial extends UpdateProductState {}
final class UpdateProductLoading extends UpdateProductState {}
final class UpdateProductSuccess extends UpdateProductState {}
final class UpdateProductFailure extends UpdateProductState {
  final String message;
  UpdateProductFailure({required this.message});
}
final class GetCategoriesLoading extends UpdateProductState {}
final class GetCategoriesSuccess extends UpdateProductState {}
final class GetCategoriesFailure extends UpdateProductState {
  final String message;
  GetCategoriesFailure({required this.message});
}
final class PickImageLoading extends UpdateProductState {}
final class PickImageSuccess extends UpdateProductState {}
final class PickImageFailure extends UpdateProductState {
  final String message;
  PickImageFailure({required this.message});
}
final class GetSubCategoriesLoading extends UpdateProductState {}
final class GetSubCategoriesSuccess extends UpdateProductState {}
final class GetSubCategoriesFailure extends UpdateProductState {
  final String message;
  GetSubCategoriesFailure({required this.message});
}
