part of 'get_categories_cubit.dart';

@immutable
sealed class GetCategoriesState {}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}

final class GetCategoriesSuccess extends GetCategoriesState {}

final class GetCategoriesFailure extends GetCategoriesState {
  final String message;
  GetCategoriesFailure({required this.message});
}

final class EmptyCategories extends GetCategoriesState {}

class DeleteCategoryLoading extends GetCategoriesState {}

class DeleteCategorySuccess extends GetCategoriesState {}

class DeleteCategoryFailure extends GetCategoriesState {
  final String message; 
  DeleteCategoryFailure({required this.message});
} // No products in database