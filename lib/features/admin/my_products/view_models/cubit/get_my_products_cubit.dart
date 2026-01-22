import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/network/supabase/database/stream_data_with_spacific.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'get_my_products_state.dart';

class GetMyProductsCubit extends Cubit<GetMyProductsState> {
  GetMyProductsCubit() : super(GetMyProductsInitial()){
    getMyProducts();
  }
  StreamSubscription? straemSubscription;
  List<ProductModel> products = [];
  getMyProducts() {
    try {
      straemSubscription = streamDataWithSpecificId(
              tableName: "products",
              id: getIt<SupabaseClient>().auth.currentUser!.id,
              primaryKey: "shop_id")
          .listen(
        (event) {
          if (event.isNotEmpty) {
            products = event.map((e) => ProductModel.fromJson(e)).toList();
            emit(GetMyProductsSuccess());
          } else {
            emit(GetMyProductsFailure(message:LocaleKeys.no_products_available.tr()));
          }
        },
        onError: (error) {
          emit(GetMyProductsFailure(message: error.toString()));
        },
      );
    } on Exception catch (e) {
      emit(GetMyProductsFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    straemSubscription?.cancel();
    return super.close();
  }
}
