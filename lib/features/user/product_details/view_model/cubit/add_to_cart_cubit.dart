import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit({required String id}) : super(AddToCartInitial());
  final cacheHelper = getIt<CacheHelper>();
  int quantity = 1;
  bool existsInCart = false;
  increaseQuantity() {
    quantity++;
    emit(UpdateQuantity());
  }

  decreaseQuantity() {
    quantity--;
    emit(UpdateQuantity());
  }

  addToCart({required ProductModel product, int quantity = 1}) async {
    try {
      if (cacheHelper.isInCart(product.id)) {
        emit(ProductExistsInCart());
        return;
      }

      final cartItems = cacheHelper.getCartItems();

      if (cartItems.isNotEmpty &&
          cartItems.first.product.shopId != product.shopId) {
        emit(AddToCartFailure(
            message:
                "You can't add products from different shops. Please complete or clear your current cart first."));
        return;
      }

      emit(AddToCartLoading());
      await cacheHelper.addToCart(product, quantity: quantity);
      emit(AddToCartSuccess());
    } catch (e, s) {
      log("AddToCart error: $e", stackTrace: s);
      emit(AddToCartFailure(message: e.toString()));
    }
  }

  removeFromCart({required String id}) async {
    try {
      emit(RemoveFromCartLoading());
      await cacheHelper.removeFromCart(id);
      emit(RemoveFromCartSuccess());
    } on Exception catch (e) {
      emit(RemoveFromCartFailure(message: e.toString()));
    }
  }

  // update product
  final supabase = getIt<SupabaseClient>();
  deleteProduct({required String id}) async {
    try {
      emit(DeleteProductLoading());
      await supabase.from('products').delete().eq('id', id);
      emit(DeleteProductSuccess());
    } on Exception catch (e) {
      emit(DeleteProductFailure(message: e.toString()));
    }
  }
}
