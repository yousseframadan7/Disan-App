import 'package:flutter/material.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';

class CustomCircleProgressIndecator extends StatelessWidget {
  const CustomCircleProgressIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.kPrimaryColor,
        strokeWidth: 3,
      ),
    );
  }
}
