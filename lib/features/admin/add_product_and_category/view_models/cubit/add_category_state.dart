part of 'add_category_cubit.dart';

@immutable
sealed class AddCategoryState {}

final class AddCategoryInitial extends AddCategoryState {}

final class AddCategoryLoading extends AddCategoryState {}

final class AddCategorySuccess extends AddCategoryState {}

final class AddCategoryFailure extends AddCategoryState {
  final String message;
  AddCategoryFailure({required this.message});
}
// pick image status
final class PickImageLoading extends AddCategoryState {}

final class PickImageSuccess extends AddCategoryState {}

final class PickImageFailure extends AddCategoryState {
  final String message;
  PickImageFailure({required this.message});
}
