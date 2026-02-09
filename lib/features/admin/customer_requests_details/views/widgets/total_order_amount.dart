import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TotalOrderAmount extends StatelessWidget {
  const TotalOrderAmount({
    super.key,
    required this.totalOrderAmount,
  });

  final double totalOrderAmount;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(SizeConfig.width * 0.04),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF104E8B).withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.total_order_amount.tr(),
              style: AppTextStyles.title18WhiteBold,
            ),
            Text(
              '${LocaleKeys.le.tr()} ${totalOrderAmount.toStringAsFixed(2)}',
              style: AppTextStyles.title20WhiteW500,
            ),
          ],
        ),
      ),
    );
  }
}

