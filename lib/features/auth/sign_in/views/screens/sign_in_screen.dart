import 'package:disan/features/auth/sign_in/views/widgets/gradiant_container.dart';
import 'package:disan/features/auth/sign_in/views/widgets/sign_in_screen_body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradiantContainer(
        child: SignInScreenBody(),
      ),
    );
  }
}
