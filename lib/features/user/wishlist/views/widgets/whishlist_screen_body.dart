import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_products_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/product_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/generated/locale_keys.g.dart';

class WishlistScreenBody extends StatelessWidget {
  const WishlistScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var products = context.read<GetProductsCubit>().products;
    return SafeArea(
      child: Column(
        children: [
          WhislistScreenAppBar(),
          SizedBox(height: SizeConfig.height * 0.01),
          Expanded(
            child: BlocBuilder<WishListCubit, WishListState>(
              builder: (context, state) {
                var cubit = context.read<WishListCubit>();
                final favPrduct = products
                    .where((product) => cubit.favorites.contains(product.id))
                    .toList();
                return favPrduct.isEmpty
                    ? Lottie.asset(AppLotties.notFoundLottie)
                    : Stack(
                        children: [
                          BlocBuilder<WishListCubit, WishListState>(
                            buildWhen: (previous, current) =>
                                current is ClearFavorite,
                            builder: (context, state) {
                              return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: SizeConfig.height * 0.01,
                                  crossAxisSpacing: SizeConfig.width * 0.02,
                                  childAspectRatio: 0.73,
                                ),
                                itemCount: cubit.favorites.length,
                                itemBuilder: (context, index) => ProductCard(
                                  product: favPrduct[index],
                                  isFavorite:
                                      cubit.isFavorite(favPrduct[index].id),
                                  onTapToggleFavorite: () => cubit
                                      .toggleFavorite(products[index].id),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: SizeConfig.height * 0.00,
                            right: SizeConfig.width * 0.2,
                            left: SizeConfig.width * 0.2,
                            child: CustomIconButton(
                                backgroundColor:
                                    AppColors.kPrimaryColor.withOpacity(0.5),
                                icon: Icons.delete_forever_outlined,
                                iconSize: SizeConfig.width * 0.1,
                                onPressed: () {
                                  context
                                      .read<WishListCubit>()
                                      .clearFavorites();
                                }),
                          ),
                        ],
                      );
              },
            ),
          ),
          SizedBox(
            height: SizeConfig.height * 0.01,
          )
        ],
      ),
    );
  }
}

class WhislistScreenAppBar extends StatelessWidget {
  const WhislistScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.width * 0.04,
        right: SizeConfig.width * 0.04,
        top: SizeConfig.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.wishlist.tr(),
            style: AppTextStyles.title24PrimaryColorBold,
          ),
          CustomIconButton(
            icon: Icons.favorite_border,
            iconColor: AppColors.kPrimaryColor,
            iconSize: SizeConfig.width * 0.08,
          )
        ],
      ),
    );
  }
}
