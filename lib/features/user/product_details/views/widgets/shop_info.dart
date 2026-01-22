import 'package:disan/core/components/cutom_out_line_button.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShopInfo extends StatelessWidget {
  const ShopInfo({
    super.key,
    required this.shopName,
    this.onPressed,
  });
  final String shopName;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.04,
        vertical: SizeConfig.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: SizeConfig.width * 0.1,
            height: SizeConfig.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag,
              size: SizeConfig.width * 0.06,
              color: AppColors.kPrimaryColor,
            ),
          ),
          SizedBox(width: SizeConfig.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shopName, style: AppTextStyles.title20BlackW600),
                Text('Verified Seller', style: AppTextStyles.title14Black38),
              ],
            ),
          ),
          SizedBox(width: SizeConfig.width * 0.06),
          Expanded(
            child: CustomOutLineButton(
              onPressed: onPressed,
              borderColor: AppColors.kPrimaryColor,
              textStyle: AppTextStyles.title16PrimaryColorW500,
              name: "Visit Shop",
            ),
          ),
        ],
      ),
    );
  }
}
