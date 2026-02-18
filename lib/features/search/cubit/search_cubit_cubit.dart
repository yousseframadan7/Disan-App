import 'package:bloc/bloc.dart';
import 'package:disan/features/search/cubit/search_cubit_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductSearchCubit extends Cubit<ProductSearchState> {
  ProductSearchCubit() : super(ProductSearchInitial());

  final SupabaseClient supabase = Supabase.instance.client;

  String selectedCategory = 'all';
  String lastSearchText = '';

  void changeCategory(String category) {
    selectedCategory = category;
  }

  Future<void> searchProducts(String text) async {
    lastSearchText = text;

    if (text.trim().isEmpty) {
      emit(ProductSearchInitial());
      return;
    }

    emit(ProductSearchLoading());

    try {
      final query = supabase.from('products').select();

      final filteredQuery = selectedCategory == 'all'
          ? query.ilike('name', '%$text%')
          : query.ilike('name', '%$text%').eq('category', selectedCategory);

      final response = await filteredQuery;

      emit(ProductSearchSuccess(response));
    } catch (e) {
      emit(ProductSearchError(e.toString()));
    }
  }
}
