import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.3,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.height * 0.05),
          Image.asset(AppImages.logoImage,
              height: SizeConfig.height * 0.12),
          Text(title, style: AppTextStyles.title28WhiteColorW500),
          Text(
            subtitle,
            style: AppTextStyles.title18WhiteW500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
