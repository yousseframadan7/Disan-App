import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndecator extends StatelessWidget {
  const CustomSmoothPageIndecator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 5,
      effect: ExpandingDotsEffect(
        dotWidth: 10,
        dotHeight: 10,
        dotColor: Colors.grey,
        activeDotColor: AppColors.kPrimaryColor,
      ),
    );
  }
}
