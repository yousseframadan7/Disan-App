import 'package:bloc/bloc.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:meta/meta.dart';
import 'package:disan/core/cache/cache_helper.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit() : super(WishListInitial()) {
    loadFavorites();
  }

  List<String> _favorites = [];

  List<String> get favorites => _favorites;

  void loadFavorites() {
    _favorites = getIt<CacheHelper>().getFavoriteIds();
    emit(WishListLoaded(_favorites));
  }

  void toggleFavorite(String id) async {
    await getIt<CacheHelper>().toggleFavorite(id);
    emit(ToggleFavorite());
    showToast(
        !isFavorite(id) ? 'Added to favorites' : 'Removed from favorites');
      
    loadFavorites();
  }
  clearFavorites() async {
    await getIt<CacheHelper>().removeData(key: 'favorites');
    loadFavorites();
    emit(ClearFavorite());
  }
  bool isFavorite(String id) {
    return _favorites.contains(id);
  }
}
