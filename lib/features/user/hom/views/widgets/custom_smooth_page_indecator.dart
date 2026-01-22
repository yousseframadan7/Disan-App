import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndecator extends StatelessWidget {
  const CustomSmoothPageIndecator({
    super.key,
    required this.pageController,
    required this.itemLength,
  });
  final PageController pageController;
  final int itemLength ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: pageController,
        count: itemLength,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.kPrimaryColor,
          dotColor: Colors.grey.shade300,
          dotHeight: SizeConfig.height * 0.01,
          dotWidth: SizeConfig.height * 0.01,
          spacing: SizeConfig.width * 0.01,
          expansionFactor: 3,
        ),
      ),
    );
  }
}
