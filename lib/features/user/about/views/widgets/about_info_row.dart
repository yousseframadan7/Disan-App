import 'package:flutter/material.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class AboutInfoRow extends StatelessWidget {
  const AboutInfoRow({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.kPrimaryColor),
        SizedBox(width: SizeConfig.width * 0.02),
        Text(
          text,
          style: AppTextStyles.title16Black,
        ),
      ],
    );
  }
}
