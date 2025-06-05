import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/sign_in/views/widgets/forget_password.dart';
import 'package:flutter/material.dart';

class SignInFields extends StatelessWidget {
  const SignInFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWithTitle(
          hintText: "enter user name",
          title: "User Name",
          //  controller: cubit.doctorUserNameController,
        ),
        SizedBox(height: SizeConfig.height * 0.015),
        CustomTextFormFieldWithTitle(
          hintText: "enter password",
          title: "Password",
          //  controller: cubit.doctorPasswordController,
          isPassword: true,
        ),
        SizedBox(height: SizeConfig.height * 0.008),
        RememberMeAndForgetPassword(),
        SizedBox(height: SizeConfig.height * 0.01),
        CustomElevatedButton(
          name: "Sign In",
          onPressed: () {
            //  cubit.signInAsDoctor();
          },
          backgroundColor: AppColors.kPrimaryColor,
        ),
      ],
    );
  }
}
