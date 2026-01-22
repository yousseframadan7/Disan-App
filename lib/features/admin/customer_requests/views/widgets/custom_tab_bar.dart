import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
  });
  final List<String> tabs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.02,
        vertical: SizeConfig.height * 0.01,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.kPrimaryColor.withOpacity(0.8),
      ),
      child: TabBar(
        dividerHeight: 0,
        labelStyle: AppTextStyles.title16White500,
        unselectedLabelStyle: AppTextStyles.title14White,
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        indicator: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: BorderRadius.circular(20),
          color: AppColors.kPrimaryColor,
        ),
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}
