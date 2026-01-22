part of 'wish_list_cubit.dart';

@immutable
abstract class WishListState {}

class WishListInitial extends WishListState {}

class WishListLoaded extends WishListState {
  final List<String> favorites;

  WishListLoaded(this.favorites);
}
class WishListError extends WishListState {}
class ToggleFavorite extends WishListState {}
class ClearFavorite extends WishListState {}
