import 'package:disan/features/auth/forget_password/views/widgets/forget_password_form_fields.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_body.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_header.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreenBody extends StatelessWidget {
  const ForgetPasswordScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthHeader(
          title: "Forget Password",
          subtitle:
              "Please enter your email address to receive a link to create a new password via email",
        ),
        AuthBody(
          child: ForgetPasswordFormFields(),
        )
      ],
    );
  }
}
