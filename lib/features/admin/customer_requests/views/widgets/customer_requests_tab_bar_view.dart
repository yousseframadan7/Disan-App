import 'package:disan/features/admin/customer_requests/view_models/cubit/get_customer_requests_cubit.dart';
import 'package:disan/features/admin/customer_requests/views/widgets/customer_requests_list_view.dart';
import 'package:flutter/material.dart';

class CustomerRequestsTabBarView extends StatelessWidget {
  const CustomerRequestsTabBarView({
    super.key,
    required this.cubit,
  });

  final GetCustomerRequestsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(children: [
        CustomerRequestsListView(
            customerRequests: cubit.pendingCustomerRequests),
        CustomerRequestsListView(
            customerRequests: cubit.processingCustomerRequests),
        CustomerRequestsListView(
            customerRequests: cubit.shippedCustomerRequests),
        CustomerRequestsListView(
            customerRequests: cubit.deliveredCustomerRequests),
      ]),
    );
  }
}


