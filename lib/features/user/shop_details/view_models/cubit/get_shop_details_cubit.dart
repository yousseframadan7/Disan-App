import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:disan/features/user/shop_products/models/shop_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'get_shop_details_state.dart';

class GetShopDetailsCubit extends Cubit<GetShopDetailsState> {
  GetShopDetailsCubit({required this.shopId}) : super(GetShopDetailsInitial()) {
    getShopDetails();
  }

  final String shopId;
  ShopModel? shopModel;
  final supabase = getIt<SupabaseClient>();
  List<ProductModel>? products = [];
  getShopDetails() async {
    try {
      emit(GetShopDetailsLoading());
      final responde =
          await supabase.from('shops').select().eq('user_id', shopId).single();
      shopModel = ShopModel.fromJson(responde);
      final response =
          await supabase.from('products').select().eq('shop_id', shopId);
      if (response.isEmpty) {
        emit(GetShopDetailsSuccess());
      } else {
        products = response
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();
        shopModel = shopModel!.copyWith(products: products);
        emit(GetShopDetailsSuccess());
      }
    } on Exception catch (e) {
      emit(GetShopDetailsFailure(message: e.toString()));
    }
  }
}
