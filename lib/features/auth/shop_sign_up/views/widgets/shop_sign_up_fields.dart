import 'package:disan/core/components/custom_drop_down_button_form_field.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field_with_title.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/auth/shop_sign_up/view_models/cubit/shop_sign_up_cubit.dart';
import 'package:disan/features/user/product_details/views/widgets/custom_circle_progress_indecator.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSignUpFields extends StatelessWidget {
  const ShopSignUpFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<ShopSignUpCubit>().getCategories();
    return BlocBuilder<ShopSignUpCubit, ShopSignUpState>(
      builder: (context, state) {
        var cubit = context.read<ShopSignUpCubit>();
        return Form(
          key: cubit.formKey,
          child: Column(
            children: [
              CustomTextFormFieldWithTitle(
                hintText:LocaleKeys.enter_shop_name.tr(),
                title:LocaleKeys.shop_name.tr(),
                controller: cubit.userNameController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText:LocaleKeys.enter_shop_email.tr(),
                title: LocaleKeys.shop_email.tr(),
                controller: cubit.emailController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText:LocaleKeys.enter_shop_address.tr(),
                title: LocaleKeys.shop_address.tr(),
                controller: cubit.addressController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              state is GetCategoriesLoading
                  ? CustomCircleProgressIndecator()
                  : CustomDropDownButtonFormField(
                      userRoles: cubit.categories.map((e) => e.name).toList(),
                      hintText:LocaleKeys.select_category.tr(),
                      controller: cubit.categoryController,
                      title: LocaleKeys.shop_category.tr(),
                    ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText: LocaleKeys.enter_shop_description.tr(),
                title:LocaleKeys.shop_description.tr(),
                controller: cubit.descriptionController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText:LocaleKeys.shop_phone.tr(),
                title: LocaleKeys.enter_shop_phone.tr(),
                controller: cubit.phoneController,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CustomTextFormFieldWithTitle(
                hintText: LocaleKeys.enter_password.tr(),
                title: LocaleKeys.password.tr(),
                isPassword: true,
                controller: cubit.passwordController,
              ),
              SizedBox(height: SizeConfig.height * 0.04),
              state is ShopSignUpLoading
                  ? CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    )
                  : CustomElevatedButton(
                      name: LocaleKeys.sign_up.tr(),
                      onPressed: () {
                        cubit.shopSignUp();
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
