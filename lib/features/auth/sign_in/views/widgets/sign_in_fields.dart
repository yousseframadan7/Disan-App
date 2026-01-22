import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';
import 'package:disan/features/auth/sign_in/views/widgets/forget_password.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInFields extends StatelessWidget {
  const SignInFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        var cubit = context.read<SignInCubit>();
        return Form(
          key: cubit.formKey,
          child: Column(
            children: [
              CustomTextFormFieldWithTitle(
                hintText:LocaleKeys.enter_user_name.tr(),// "enter user name",
                title:LocaleKeys.user_name.tr(),// "User Name",
                 controller: cubit.emailController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText:LocaleKeys.enter_password.tr(),// "enter password",
                title:LocaleKeys.password.tr(),// "Password",
                 controller: cubit.passwordController,
                isPassword: true,
              ),
              SizedBox(height: SizeConfig.height * 0.008),
              RememberMeAndForgetPassword(),
              SizedBox(height: SizeConfig.height * 0.01),
              state is SignInLoading
                  ? CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    )
                  : CustomElevatedButton(
                      name:LocaleKeys.sign_in.tr(),// "Sign In",
                      onPressed: () {
                         cubit.signIn();
                      },
                      backgroundColor: AppColors.kPrimaryColor,
                    ),
            ],
          ),
        );
      },
    );
  }
}
