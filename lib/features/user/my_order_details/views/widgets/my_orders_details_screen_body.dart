import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_requests/models/customer_request_model.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/order_item_card.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/total_order_amount.dart';
import 'package:flutter/material.dart';

class MyOrdersDetailsScreenBody extends StatelessWidget {
  const MyOrdersDetailsScreenBody(
      {super.key, required this.customerRequestModel});
  final CustomerRequestModel customerRequestModel;
  @override
  Widget build(BuildContext context) {
    double totalOrderAmount = customerRequestModel.orders!.fold(
      0,
      (sum, item) => sum + (item.product!.price * item.quantity),
    );
    return Scaffold(
        body: SafeArea(
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
                  var item = customerRequestModel.orders![index];
                  return OrderItemCard(item: item);
                },
                childCount: customerRequestModel.orders!.length,
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(height: SizeConfig.height * 0.02)),
            TotalOrderAmount(totalOrderAmount: totalOrderAmount),
          ],
        ),
      ),
    ));
  }
}
