import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/user/shop_products/models/shop_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_shops_by_category_state.dart';

class GetShopsByCategoryCubit extends Cubit<GetShopsByCategoryState> {
  GetShopsByCategoryCubit({required this.categoryId})
      : super(GetShopsByCategoryInitial()) {
    getShopsByCategory();
  }
  final String categoryId;
  List<ShopModel> shops = [];
  final supabse = getIt<SupabaseClient>();
  getShopsByCategory() async {
    try {
      emit(GetShopsByCategoryLoading());
      final response = await supabse
          .from('shops')
          .select()
          .eq('category_id', categoryId)
          .order('created_at', ascending: false);
      log(response.toString());
      if (response.isEmpty) {
        emit(EmptyShops());
      } else {
        shops = response.map((e) => ShopModel.fromJson(e)).toList();
        emit(GetShopsByCategorySuccess());
      }
    } catch (e) {
      emit(GetShopsByCategoryFailure(message: e.toString()));
    }
  }
}
