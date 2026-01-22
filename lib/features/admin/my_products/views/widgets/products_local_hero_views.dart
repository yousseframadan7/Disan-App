import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/translate_text.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/my_products/view_models/cubit/get_my_products_cubit.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_hero_transform/local_hero_transform.dart';
import 'package:shimmer/shimmer.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';

class ProductsLocalHeroViews extends StatelessWidget {
  const ProductsLocalHeroViews({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetMyProductsCubit, GetMyProductsState>(
        builder: (context, state) {
          if (state is GetMyProductsLoading) {
            return const ProductShimmer();
          }
          if (state is GetMyProductsFailure) {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: AppTextStyles.title24PrimaryColorBold,
              ),
            );
          }
          var cubit = context.read<GetMyProductsCubit>();
          var itemsMode = cubit.products;
          return LocalHeroViews(
            tabController: _tabController!,
            itemCount: itemsMode.length,
            itemsModel: (index) {
              final item = itemsMode[index];
              return ItemsModel(
                cardStyleMode: CardStyleMode(
                  isLoading: cubit.products.isEmpty,
                ),
                name: TranslateText(
                    text: item.name, style: AppTextStyles.title20BlackBold),
                title: Text(
                  "${LocaleKeys.price.tr()} : ${itemsMode[index].price} LE",
                  style: AppTextStyles.title14BlackColorW400.copyWith(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                subTitle: TranslateText(
                  text: item.description,
                  maxLines: 1,
                  style: AppTextStyles.title14Grey,
                ),
                favoriteIconButton: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.transparent,
                  ),
                ),
                image: DecorationImage(image: NetworkImage(item.image)),
              );
            },
            onPressedCard: (int index) {
              context.pushScreen(
                RouteNames.productDetailsScreen,
                arguments: itemsMode[index].toJson(),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.height * 0.01,
                horizontal: SizeConfig.width * 0.02,
              ),
              child: Container(
                height: SizeConfig.height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: SizeConfig.width * 0.3,
                      height: SizeConfig.height * 0.15,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: SizeConfig.width * 0.4,
                              height: 18,
                              color: Colors.white,
                            ),
                            SizedBox(height: SizeConfig.height * 0.01),
                            Container(
                              width: SizeConfig.width * 0.5,
                              height: 14,
                              color: Colors.white,
                            ),
                            SizedBox(height: SizeConfig.height * 0.005),
                            Container(
                              width: SizeConfig.width * 0.3,
                              height: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
