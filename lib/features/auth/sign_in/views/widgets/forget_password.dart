import 'package:flutter/material.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/custom_text_button.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';

class RememberMeAndForgetPassword extends StatefulWidget {
  const RememberMeAndForgetPassword({super.key});

  @override
  State<RememberMeAndForgetPassword> createState() =>
      _RememberMeAndForgetPasswordState();
}

class _RememberMeAndForgetPasswordState
    extends State<RememberMeAndForgetPassword> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: (value) {
                setState(() {
                  rememberMe = value ?? false;
                });
              },
            ),
            Text("Remember Me"),
            const Spacer(),
            CustomTextButton(
              title: "Forget Password?",
              onPressed: () {
                context.pushScreen(RouteNames.forgetPasswordScreen);
              },
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ],
    );
  }
}
