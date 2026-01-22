import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/customer_requests/models/customer_request_model.dart';
import 'package:disan/features/admin/customer_requests_details/models/order_item_model.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_my_orders_state.dart';

class GetMyOrdersCubit extends Cubit<GetMyOrdersState> {
  GetMyOrdersCubit() : super(GetMyOrdersInitial()) {
    getMyOrders();
  }

  final supabase = getIt<SupabaseClient>();
  List<CustomerRequestModel> customerOrders = [];

  Future<void> getMyOrders() async {
    try {
      emit(GetMyOrdersLoading());

      final user = supabase.auth.currentUser;
      if (user == null) {
        emit(GetMyOrdersFailure(
            message: "Session expired. Please log in again."));
        return;
      }

      final ordersResponse =
          await supabase.from('orders').select().eq('customer_id', user.id);

      for (var orderJson in ordersResponse) {
        final order = CustomerRequestModel.fromJson(orderJson);

        final orderItemsResponse = await supabase
            .from('order_items')
            .select()
            .eq('order_id', order.id);

        List<OrderItemModel> orderItems = [];

        for (var itemJson in orderItemsResponse) {
          final productId = itemJson['product_id'];

          final productResponse = await supabase
              .from('products')
              .select()
              .eq('id', productId)
              .single();

          final product = ProductModel.fromJson(productResponse);

          final item = OrderItemModel.fromJson({
            ...itemJson,
            'product': productResponse,
          });
          item.product = product;
          orderItems.add(item);
          order.orders = orderItems;
        }
        customerOrders.add(order);
      }

      emit(GetMyOrdersSuccess());
    } on Exception catch (e) {
      emit(GetMyOrdersFailure(message: e.toString()));
    }
  }
}
