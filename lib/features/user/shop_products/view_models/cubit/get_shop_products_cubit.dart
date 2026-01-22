import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'get_shop_products_state.dart';

class GetShopProductsCubit extends Cubit<GetShopProductsState> {
  GetShopProductsCubit({required this.shopId})
      : super(GetShopProductsInitial()) {
    getShopProducts();
  }
  final String shopId;
  List<ProductModel> products = [];
  final supabase = getIt<SupabaseClient>();
  getShopProducts() async {
    try {
      emit(GetShopProductsLoading());
      final response =
          await supabase.from('products').select().eq('shop_id', shopId);
      if (response.isEmpty) {
        emit(EmptyShopProducts());
      } else {
        products = response
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();
        emit(GetShopProductsSuccess());
      }
    } catch (e) {
      emit(GetShopProductsFailure(message: e.toString()));
    }
  }
}
