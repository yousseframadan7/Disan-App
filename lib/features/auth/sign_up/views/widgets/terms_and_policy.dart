import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
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
            // context.read<SignUpCubit>().changeAcceptTerms();
          },
        ),
        Text.rich(
          TextSpan(
            text: 'I understood the ',
            style: AppTextStyles.title18Black,
            children: [
              TextSpan(
                text: 'terms & policy',
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
