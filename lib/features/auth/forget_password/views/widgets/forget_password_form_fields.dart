import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class ForgetPasswordFormFields extends StatelessWidget {
  const ForgetPasswordFormFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWithTitle(
          hintText: "enter your email",
          title: "Email",
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.height * 0.015,
            horizontal: SizeConfig.width * 0.05,
          ),
          child: Divider(),
        ),
        CustomTextFormFieldWithTitle(
          hintText: "enter new password",
          title: "Password",
          isPassword: true,
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        CustomTextFormFieldWithTitle(
          hintText: "enter confirm password",
          title: "Confirm Password",
          isPassword: true,
        ),
        SizedBox(height: SizeConfig.height * 0.1),
        CustomElevatedButton(name: "Reset Password", onPressed: () {}),
      ],
    );
  }
}
