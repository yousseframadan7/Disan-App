import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/customer_sign_up/view_models/cubit/customer_sign_up_cubit.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerSignUpFields extends StatelessWidget {
  const CustomerSignUpFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerSignUpCubit, CustomerSignUpState>(
      builder: (context, state) {
        var cubit = context.read<CustomerSignUpCubit>();
        return Form(
          key: cubit.formKey,
          child: Column(
            children: [
              CustomTextFormFieldWithTitle(
                hintText: LocaleKeys.enter_user_name.tr(),
                title: LocaleKeys.user_name.tr(),
                controller: cubit.userNameController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText: LocaleKeys.enter_your_email.tr(),
                title: LocaleKeys.email.tr(),
                controller: cubit.emailController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText: LocaleKeys.enter_password.tr(),
                title: LocaleKeys.password.tr(),
                isPassword: true,
                controller: cubit.passwordController,
              ),
              SizedBox(height: SizeConfig.height * 0.04),
              state is SignUpLoading
                  ? CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    )
                  : CustomElevatedButton(
                      name: LocaleKeys.sign_up.tr(),
                      onPressed: () {
                        cubit.customerSignUp();
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
