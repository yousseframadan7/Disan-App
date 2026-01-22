part of 'get_products_cubit.dart';

@immutable
abstract class GetProductsState {}

class GetProductsInitial extends GetProductsState {}

class GetProductsLoading extends GetProductsState {}

class GetProductsSuccess extends GetProductsState {}

class EmptyProducts extends GetProductsState {} // No products in database

class EmptyFilteredProducts extends GetProductsState {} // No products after filtering

class GetProductsFailure extends GetProductsState {
  final String message;
  GetProductsFailure({required this.message});
}
class LoadingMoreProducts extends GetProductsState {}
class GetSubCategoriesLoading extends GetProductsState {}

class GetSubCategoriesSuccess extends GetProductsState {}

class EmptySubCategories extends GetProductsState {} // No products in database

class GetSubCategoriesFailure extends GetProductsState {
  final String message;
  GetSubCategoriesFailure({required this.message});
}
