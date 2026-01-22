import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.02,
        vertical: SizeConfig.height * 0.005,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        category,
        style: AppTextStyles.title12WhiteW500,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
