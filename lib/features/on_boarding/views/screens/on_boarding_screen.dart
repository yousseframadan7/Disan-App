import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/features/on_boarding/views/widgets/on_boarding_screen_body.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: OnBoardingScreenBody(),
      ),
    );
  }
}
