import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_products_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/categories_list.dart';
import 'package:disan/features/user/hom/views/widgets/discount_list_view.dart';
import 'package:disan/features/user/hom/views/widgets/search_bar.dart';
import 'package:disan/features/user/hom/views/widgets/title_with_view_all.dart';
import 'package:disan/features/user/hom/views/widgets/top_selling_grid_view.dart';
import 'package:disan/features/user/hom/views/widgets/trending_shops.dart';
import 'package:disan/features/user/home/view_models/cubit/post_cubit.dart';
import 'package:disan/features/user/home/views/screens/home_screen_body.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomeScreenTabBarView extends StatelessWidget {
  const UserHomeScreenTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          Column(
            children: [
              SizedBox(height: SizeConfig.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.03,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: HomrScreenSearchBar(),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await context.read<GetProductsCubit>().fetchProducts();
                  },
                  color: AppColors.kPrimaryColor,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width * 0.03,
                          vertical: SizeConfig.height * 0.01,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DiscountListView(),
                              SizedBox(height: SizeConfig.height * 0.02),
                              CategoriesList(),
                              SizedBox(height: SizeConfig.height * 0.02),
                              TrendingShops(),
                              SizedBox(height: SizeConfig.height * 0.03),
                              TitleWithViewAll(
                                title: LocaleKeys.top_selling.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width * 0.01,
                        ),
                        sliver: const TopSellingGridView(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ✅ التاب التاني (TimeLines)
          BlocProvider(
            create: (context) => PostCubit(),
            child: const TimeLinesTab(),
          ),
        ],
      ),
    );
  }
}
