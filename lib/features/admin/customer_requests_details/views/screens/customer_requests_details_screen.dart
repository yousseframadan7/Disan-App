import 'package:disan/features/admin/customer_requests_details/views/widgets/customer_requests_details_screen_body.dart';
import 'package:flutter/material.dart';

class CustomerRequestsDetailsScreen extends StatelessWidget {
  const CustomerRequestsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: CustomerRequestsDetailsScreenBody(args: args),
    );
  }
}

