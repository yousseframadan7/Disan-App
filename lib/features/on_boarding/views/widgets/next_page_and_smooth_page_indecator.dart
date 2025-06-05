import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/on_boarding/view_models/cubit/on_boarding_cubit.dart';
import 'package:disan/features/on_boarding/views/widgets/custom_smooth_page_indecator.dart';
import 'package:flutter/material.dart';

class NextPageAndSmoothPageIndecator extends StatelessWidget {
  const NextPageAndSmoothPageIndecator({
    super.key,
    required this.cubit,
  });

  final OnBoardingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.05,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomSmoothPageIndecator(
              pageController: cubit.pageController,
            ),
            SizedBox(
              height: SizeConfig.height * 0.09,
              width: SizeConfig.height * 0.09,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.height * 0.08,
                    width: SizeConfig.height * 0.08,
                    child: CircularProgressIndicator(
                      strokeWidth: SizeConfig.width * 0.01,
                      value: cubit.percentage,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.kPrimaryColor),
                    ),
                  ),
                  Container(
                    height: SizeConfig.height * 0.065,
                    width: SizeConfig.height * 0.065,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kPrimaryColor,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: SizeConfig.height * 0.045,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        cubit.nextPage();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
