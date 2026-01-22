import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreenTabBar extends StatelessWidget {
  const HomeScreenTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height * 0.008,
      ),
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: AppColors.kPrimaryColor,width: 2),
      ),
      child: TabBar(
        dividerHeight: 0,
        indicator: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(36),
        ),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.02),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: AppTextStyles.title18WhiteBold,
        unselectedLabelStyle: AppTextStyles.title16Black,
        tabs: [
          Tab(
            text:LocaleKeys.Shops.tr(), // 'Shops',
          ),
          Tab(
            text: LocaleKeys.Timeline.tr(), // 'Categories',
          ),
        ],
      ),
    );
  }
}
