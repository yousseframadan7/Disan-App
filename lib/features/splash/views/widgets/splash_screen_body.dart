import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor.withOpacity(0.5),
            AppColors.kSecondaryColor.withOpacity(0.5),
            AppColors.kThirdColor.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logoImage,
            width: SizeConfig.width * 0.8,
          )
              .animate()
              .slide(
                duration: 1000.ms,
                begin: const Offset(1, 0),
                curve: Curves.easeOutCubic,
              )
              .fadeIn(duration: 1000.ms)
              .scale(duration: 1000.ms)
              .then(delay: 300.ms),
          SizedBox(height: SizeConfig.height * 0.03),
          Text(
            "Shop with ease.. Sell with confidence",
            style: AppTextStyles.title28WhiteW500.copyWith(
              height: 1.4,
              shadows: [
                const Shadow(
                  blurRadius: 4,
                  color: Colors.black45,
                  offset: Offset(1, 2),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
              .animate(delay: 1000.ms)
              .fadeIn(duration: 1000.ms)
              .slideY(begin: 0.3, duration: 800.ms),
        ],
      ),
    );
  }
}
