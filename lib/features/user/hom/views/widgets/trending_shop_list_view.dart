import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_trending_shops_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/custom_smooth_page_indecator.dart';
import 'package:disan/features/user/hom/views/widgets/title_with_view_all.dart';
import 'package:disan/features/user/hom/views/widgets/trending_shop_card.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TrendingShopListView extends StatelessWidget {
  final GetTrendingShopsCubit shopsCubit;
  const TrendingShopListView({super.key, required this.shopsCubit});

  @override
  Widget build(BuildContext context) {
    final shops = shopsCubit.shops;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithViewAll(title: LocaleKeys.trending_shops.tr()),
        SizedBox(height: SizeConfig.height * 0.015),
        SizedBox(
          height: SizeConfig.height * 0.25,
          child: PageView.builder(
            controller: shopsCubit.pageController,
            itemCount: shops.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: SizeConfig.width * 0.03),
                child: TrendingShopCard(shop: shops[index]),
              );
            },
          ),
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        CustomSmoothPageIndecator(
          itemLength: shops.length  ,
          pageController: shopsCubit.pageController,
        ),
        SizedBox(height: SizeConfig.height * 0.015),
      ],
    );
  }
}
