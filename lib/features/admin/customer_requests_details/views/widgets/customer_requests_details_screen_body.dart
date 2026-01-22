import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_requests_details/view_models/cubit/get_order_items_cubit.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/order_item_card.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/total_order_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerRequestsDetailsScreenBody extends StatelessWidget {
  const CustomerRequestsDetailsScreenBody({
    super.key,
    required this.args,
  });

  final String args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetOrderItemsCubit(orderId: args),
      child: BlocBuilder<GetOrderItemsCubit, GetOrderItemsState>(
        builder: (context, state) {
          if (state is GetOrderItemsFailure) {
            return CustomFailureMesage(
              errorMessage: state.message,
            );
          }
          if (state is GetOrderItemsLoading) {
            return CustomLoading();
          }
          var cubit = context.read<GetOrderItemsCubit>();
          double totalOrderAmount = cubit.orderItems.fold(
            0,
            (sum, item) => sum + (item.product!.price * item.quantity),
          );
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.02,
                vertical: SizeConfig.height * 0.01,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var item = cubit.orderItems[index];
                        return OrderItemCard(item: item);
                      },
                      childCount: cubit.orderItems.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: SizedBox(height: SizeConfig.height * 0.02)),
                  TotalOrderAmount(totalOrderAmount: totalOrderAmount),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
