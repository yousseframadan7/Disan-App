import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_body.dart';
import 'package:disan/features/auth/sign_in/views/widgets/auth_header.dart';
import 'package:disan/features/auth/sign_up/views/widgets/have_account_or_not.dart';
import 'package:disan/features/auth/sign_up/views/widgets/or_with_divider.dart';
import 'package:disan/features/auth/sign_up/views/widgets/sign_up_fields.dart';
import 'package:disan/features/auth/sign_up/views/widgets/social_sign.dart';
import 'package:flutter/material.dart';

class SignUpScreenBody extends StatelessWidget {
  const SignUpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthHeader(
          title: "Welcome Back! ",
          subtitle: "Welcome back! please enter your details",
        ),
        AuthBody(
          child: Column(
            children: [
              SignUpFields(),
              const OrWithDivider(),
              const SocialSign(),
              HaveAccountOrNot(
                title: "have an account",
                btnText: "Sign In",
                onPressed: () => context.pushScreen(RouteNames.signInScreen),
              ),
            ],
          ),
        )
      ],
    );
  }
}
