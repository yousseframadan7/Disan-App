import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/custom_text_form_field.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/profile_details/view_models/cubit/update_profile_cubit.dart';
import 'package:disan/features/user/profile_details/views/widgets/pick_image.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetailsFields extends StatelessWidget {
  const ProfileDetailsFields({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UpdateProfileCubit>();
    return BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            state is PickImageLoading
                ? SizedBox(
                    height: SizeConfig.height * 0.2,
                    child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor),
                    ),
                  )
                : PickImage(
                    onTap: () {
                      cubit.pickProfileImage();
                    },
                    networkImage: cubit.userModel!.image,
                    fileImage: cubit.image,
                  ),
            SizedBox(height: SizeConfig.height * 0.01),
            Chip(
              label: Text(cubit.userModel!.role),
              backgroundColor: AppColors.kPrimaryColor,
              labelStyle: AppTextStyles.title18WhiteW500,
            ),
            SizedBox(height: SizeConfig.height * 0.05),
            CustomTextFormField(
              hintText: LocaleKeys.your_name.tr(),
              label: LocaleKeys.your_name.tr(),
              controller: cubit.nameController,
            ),
            SizedBox(height: SizeConfig.height * 0.015),
            CustomTextFormField(
              hintText: LocaleKeys.your_email.tr(),
              label: LocaleKeys.your_email.tr(),
              controller: cubit.emailController,
            ),
            SizedBox(height: SizeConfig.height * 0.015),
            CustomTextFormField(
              hintText: LocaleKeys.your_phone_number.tr(),
              label: LocaleKeys.your_phone_number.tr(),
              controller: cubit.phoneController,
            ),
            SizedBox(height: SizeConfig.height * 0.05),
            state is UpdateProfileLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  )
                : CustomElevatedButton(
                    name: LocaleKeys.update.tr(),
                    onPressed: () {
                      cubit.updateProfile();
                    }),
          ],
        );
      },
    );
  }
}
