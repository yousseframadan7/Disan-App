import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/add_product_and_category/views/widgets/add_category_tab_bar_view.dart';
import 'package:disan/features/admin/add_product_and_category/views/widgets/add_product_tab_bar_view.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddProductAndCategoryScreenBody extends StatelessWidget {
  const AddProductAndCategoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.005,
          ),
          child: Column(
            children: [
              TabBar(
                indicator: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: AppTextStyles.title18WhiteBold,
                unselectedLabelStyle: AppTextStyles.title16BlackW500,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                tabs:  [
                  Tab(text:LocaleKeys.product.tr(), ),
                  Tab(text:LocaleKeys.category.tr(), ), // "Category"),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  AddProductTabBarView(),
                  AddCategoryTabBarView(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
