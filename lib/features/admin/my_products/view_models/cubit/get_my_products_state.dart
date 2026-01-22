part of 'get_my_products_cubit.dart';

@immutable
sealed class GetMyProductsState {}

final class GetMyProductsInitial extends GetMyProductsState {}

final class GetMyProductsLoading extends GetMyProductsState {}

final class GetMyProductsSuccess extends GetMyProductsState {}

final class GetMyProductsFailure extends GetMyProductsState {
  final String message;
  GetMyProductsFailure({required this.message});
}
