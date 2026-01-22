import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: false,
          activeColor: AppColors.kPrimaryColor,
          onChanged: (value) {
            // context.read<CustomerSignUpCubit>().changeAcceptTerms();
          },
        ),
        Text.rich(
          TextSpan(
            text: LocaleKeys.i_understood.tr(),
            style: AppTextStyles.title18Black,
            children: [
              TextSpan(
                text:LocaleKeys.terms_and_policy.tr(), // 'terms & policy',
                style: AppTextStyles.title18PrimaryColorW500,
              ),
              TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }
}
