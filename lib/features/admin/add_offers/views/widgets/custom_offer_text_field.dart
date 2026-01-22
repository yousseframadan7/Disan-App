import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';

class CustomOfferTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? prefixText;
  final bool isRequired;
  final IconData? icon;
  final TextEditingController? controller;
  const CustomOfferTextField({
    super.key,
    this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.prefixText,
    this.isRequired = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: SizeConfig.height * 0.03,
                color: AppColors.kPrimaryColor,
              ),
              SizedBox(width: SizeConfig.width * 0.02),
            ],
            RichText(
              text: TextSpan(
                text: label,
                style: AppTextStyles.title18BlackW600,
                children: isRequired
                    ? [
                        TextSpan(
                            text: ' *',
                            style: AppTextStyles.title18PrimaryColorW500),
                      ]
                    : [
                        TextSpan(
                            text: '  (${LocaleKeys.optional.tr()})',
                            style: AppTextStyles.title18PrimaryColorW500),
                      ],
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        TextField(
          maxLines: maxLines,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.title16Grey,
            prefixText: prefixText,
            prefixStyle: AppTextStyles.title18BlackW600,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.kPrimaryColor,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.02,
            ),
          ),
          style:AppTextStyles.title16BlackW500,
        ),
      ],
    );
  }
}
