import 'package:disan/features/admin/customer_requests/models/customer_request_model.dart';
import 'package:disan/features/user/my_order_details/views/widgets/my_orders_details_screen_body.dart';
import 'package:flutter/material.dart';

class MyOrdersDetailsScreen extends StatelessWidget {
  const MyOrdersDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var customerRequestModel = CustomerRequestModel.fromJson(args);
    return Scaffold(
      body:
          MyOrdersDetailsScreenBody(customerRequestModel: customerRequestModel),
    );
  }
}

