import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/get_all_products/cubit/get_all_products_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  final SupabaseClient supabase = getIt<SupabaseClient>();

  GetAllProductsCubit() : super(GetAllProductsInitial());

  final List<Map<String, dynamic>> _cachedProducts = [];

  Future<void> fetchAllProducts({bool forceRefresh = false}) async {
    if (_cachedProducts.isNotEmpty && !forceRefresh) {
      emit(GetAllProductsLoaded(products: _cachedProducts));
      return;
    }

    emit(GetAllProductsLoading());

    try {
      final response = await supabase.from('products').select();

      _cachedProducts
        ..clear()
        ..addAll(List<Map<String, dynamic>>.from(response));

      emit(GetAllProductsLoaded(products: _cachedProducts));
    } catch (e) {
      emit(
        GetAllProductsError(errorMessage: 'Error while fetching products: $e'),
      );
    }
  }

  Future<void> refreshProducts() async {
    await fetchAllProducts(forceRefresh: true);
  }

  void clearCache() {
    _cachedProducts.clear();
  }
}
