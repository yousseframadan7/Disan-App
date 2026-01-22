import 'package:disan/features/admin/customer_details/views/widgets/customer_details_screen_body.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:flutter/material.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var userModel = UserModel.fromJson(args);
    return Scaffold(body: CustomerDetailsScreenBody(userModel: userModel));
  }
}
