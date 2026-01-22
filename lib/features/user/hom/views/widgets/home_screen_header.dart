import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.g_translate,
                  size: SizeConfig.width * 0.065, color: Colors.black87),
              SizedBox(width: SizeConfig.width * 0.02),
              Icon(Icons.play_arrow_rounded,
                  size: SizeConfig.width * 0.065, color: Colors.black87),
            ],
          ),
          Row(
            children: [
              Image.asset(AppImages.logoImage, height: SizeConfig.height * 0.05),
              SizedBox(width: SizeConfig.width * 0.02),
              Text('Disan', style: AppTextStyles.title20BlackBold),
            ],
          ),
          Row(
            children: [
              SizedBox(width: SizeConfig.width * 0.03),
              Icon(Icons.notifications_rounded, size: SizeConfig.width * 0.065),
            ],
          ),
        ],
      ),
    );
  }
}
