import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/network/supabase/database/add_data.dart';
import 'package:disan/core/notifications/fcm_notification.dart';
import 'package:disan/features/user/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
part 'order_product_state.dart';

class OrderProductCubit extends Cubit<OrderProductState> {
  OrderProductCubit() : super(OrderProductInitial()) {
    getMuProducts();
  }

  List<CartItemModel> carts = [];
  increaseQuantity({required String id}) {
    final index = carts.indexWhere((element) => element.product.id == id);
    if (index != -1) {
      carts[index].quantity++;
      emit(UpdateQuantity());
    }
  }

  decreaseQuantity({required String id}) {
    final index = carts.indexWhere((element) => element.product.id == id);
    if (index != -1 && carts[index].quantity > 1) {
      carts[index].quantity--;
      emit(UpdateQuantity());
    }
  }

  getMuProducts() {
    carts = getIt<CacheHelper>().getCartItems();
    if (carts.isEmpty) {}
  }

  orderProducts() async {
    try {
      emit(OrderProductLoading());
      final uuid = Uuid().v4();
      await addData(tableName: "orders", data: {
        "id": uuid,
        "shop_id": carts.first.product.shopId,
        "customer_id": getIt<SupabaseClient>().auth.currentUser!.id,
        "total_amount": carts.fold(
            0.0, (sum, item) => sum + (item.quantity * item.product.price)),
      });
      for (final cart in carts) {
        await addData(
          tableName: "order_items",
          data: {
            "order_id": uuid,
            "product_id": cart.product.id,
            "quantity": cart.quantity,
            "price_at_time": cart.product.price
          },
        );
      }
      final adminDetails = await getIt<SupabaseClient>()
          .from("users")
          .select("token")
          .eq("id", carts.first.product.shopId)
          .single();

      final List<dynamic> tokens = adminDetails["token"] ?? [];
      log(tokens.toString());
      for (final token in tokens) {
        await getIt<NotificationsHelper>().sendNotification(
          title: "New Order",
          body:
              "You have a new order from ${getIt<CacheHelper>().getUserModel()!.name}",
          type: "order",
          token: token,
        );
      }
      await getIt<CacheHelper>().clearCart();
      getMuProducts();
      emit(OrderProductSuccess());
    } on Exception catch (e) {
      log(e.toString());
      emit(OrderProductFailure(message: e.toString()));
    }
  }

  deleteProduct({required String id}) async {
    await getIt<CacheHelper>().removeFromCart(id);
    getMuProducts();
    emit(DeleteProduct());
  }
}
