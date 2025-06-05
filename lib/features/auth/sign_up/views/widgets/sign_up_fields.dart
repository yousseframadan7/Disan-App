import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/sign_up/views/widgets/terms_and_policy.dart';
import 'package:flutter/material.dart';

class SignUpFields extends StatelessWidget {
  const SignUpFields({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextFormFieldWithTitle(
            hintText: "enter user name",
            title: "User Name",
            // controller: cubit.studentUserNameController,
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          CustomTextFormFieldWithTitle(
            hintText: "enter email",
            title: "Email",
            // controller: cubit.studentEmailController,
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          CustomTextFormFieldWithTitle(
            hintText: "enter password",
            title: "Password",
            isPassword: true,
            // controller: cubit.studentPasswordController,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          TermsAndPolicy(),
          SizedBox(height: SizeConfig.height * 0.005),
          CustomElevatedButton(
            name: "Sign Up",
            onPressed: () {
              // cubit.signUpAsStudent();
            },
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
