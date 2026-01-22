import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:flutter/material.dart';

class GradiantBody extends StatelessWidget {
  const GradiantBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.kPrimaryColor.withOpacity(0.8),
            AppColors.kSecondaryColor.withOpacity(0.8),
          ],
        ),
      ),
    );
  }
}
