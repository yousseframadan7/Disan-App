import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/customer_requests_details/models/order_item_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'get_order_items_state.dart';

class GetOrderItemsCubit extends Cubit<GetOrderItemsState> {
  GetOrderItemsCubit({required this.orderId}) : super(GetOrderItemsInitial()) {
    getOrderItems();
  }

  final String orderId;
  final supabase = getIt<SupabaseClient>();
  List<OrderItemModel> orderItems = [];

  Future<void> getOrderItems() async {
    try {
      emit(GetOrderItemsLoading());
      final response = await supabase
          .from('order_items')
          .select('*, product:products(*)')
          .eq('order_id', orderId);
      orderItems =
          response.map<OrderItemModel>((e) => OrderItemModel.fromJson(e)).toList();
      emit(GetOrderItemsSuccess());
    } catch (e) {
      emit(GetOrderItemsFailure(message: e.toString()));
    }
  }
}
