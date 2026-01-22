import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/user/shop_products/models/shop_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_trending_shops_state.dart';

class GetTrendingShopsCubit extends Cubit<GetTrendingShopsState> {
  GetTrendingShopsCubit() : super(GetTrendingShopsInitial()) {
    getShops();
    changeTrendingShop();
  }

  final supabase = getIt<SupabaseClient>();
  final PageController pageController = PageController();

  List<ShopModel> shops = [];

  Future<void> getShops() async {
    try {
      emit(GetTrendingShopsLoading());

      final response = await supabase.from('shops').select();
      if (response.isEmpty) {
        emit(EmptyTrendingShops());
      } else {
        shops = response.map((e) => ShopModel.fromJson(e)).toList();
        emit(GetTrendingShopsSuccess());
      }
    } catch (e) {
      emit(GetTrendingShopsFailure(message: e.toString()));
    }
  }

  changeTrendingShop() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      if (pageController.hasClients && shops.isNotEmpty) {
        int nextPage = (pageController.page?.round() ?? 0) + 1;

        if (nextPage >= shops.length) {
          nextPage = 0; // يرجع لأول صفحة
        }

        pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
