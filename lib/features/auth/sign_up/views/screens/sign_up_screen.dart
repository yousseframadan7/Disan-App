import 'package:disan/features/auth/sign_in/views/widgets/gradiant_container.dart';
import 'package:disan/features/auth/sign_up/views/widgets/sign_up_screen_body.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradiantContainer(
        child: SignUpScreenBody(),
      ),
    );
  }
}
