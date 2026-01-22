import 'package:disan/features/auth/customer_sign_up/views/widgets/customer_sign_up_screen_body.dart';
import 'package:flutter/material.dart';

class CustomerSignUpScreen extends StatelessWidget {
  const CustomerSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomerSignUpScreenBody(),
    );
  }
}
