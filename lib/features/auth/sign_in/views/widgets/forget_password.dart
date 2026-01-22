import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
              activeColor: AppColors.kPrimaryColor,
            ),
            Text(
             LocaleKeys.remember_me.tr(), // "Remember Me",
              style: AppTextStyles.title16Black,
            ),
            const Spacer(),
            CustomTextButton(
              title:LocaleKeys.forget_password.tr(), // "Forget Password?",
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
