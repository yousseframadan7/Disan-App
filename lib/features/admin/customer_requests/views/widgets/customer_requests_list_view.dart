import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/features/admin/customer_requests/models/customer_request_model.dart';
import 'package:disan/features/admin/customer_requests/views/widgets/customer_request_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomerRequestsListView extends StatelessWidget {
  const CustomerRequestsListView({
    super.key,
    required this.customerRequests,
  });

  final List<CustomerRequestModel> customerRequests;

  @override
  Widget build(BuildContext context) {
    return customerRequests.isEmpty
        ? Lottie.asset(AppLotties.emptyRequestsLottie)
        : ListView.builder(
            itemCount: customerRequests.length,
            itemBuilder: (context, index) {
              return CustomerRequestListTile(
                  customerRequests: customerRequests[index]);
            },
          );
  }
}
