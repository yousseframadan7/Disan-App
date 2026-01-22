import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class GradiantHeader extends StatelessWidget {
  const GradiantHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height * 0.4,
      width: SizeConfig.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kSecondaryColor.withOpacity(0.8),
            AppColors.kPrimaryColor.withOpacity(0.8),
            AppColors.kThirdColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
