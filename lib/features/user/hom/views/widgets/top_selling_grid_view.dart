import 'package:disan/features/user/hom/view_models/cubit/get_products_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/product_card.dart';
import 'package:disan/features/user/hom/views/widgets/product_card_shimer.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class TopSellingGridView extends StatelessWidget {
  const TopSellingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsCubit, GetProductsState>(
      builder: (context, state) {
        final cubit = context.read<GetProductsCubit>();
        if (state is GetProductsLoading && !cubit.isFetchingMore) {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, __) => const ProductCardShimmer(),
              childCount: 6,
            ),
          );
        }

        if (state is EmptyProducts) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.width * 0.04),
                child: Text(LocaleKeys.no_products_available.tr()),
              ),
            ),
          );
        }
        var products = cubit.filteredProducts;
        return BlocBuilder<WishListCubit, WishListState>(
          builder: (context, state) {
            var wishListcubit = context.read<WishListCubit>();
            return SliverList(
              delegate: SliverChildListDelegate.fixed([
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: SizeConfig.width * 0.005,
                    mainAxisSpacing: SizeConfig.height * 0.005,
                  ),
                  itemCount: products.length,
                  itemBuilder: (_, index) => ProductCard(
                    product: products[index],
                    isFavorite: wishListcubit.isFavorite(products[index].id),
                    onTapToggleFavorite: () =>
                        wishListcubit.toggleFavorite(products[index].id),
                  ),
                ),
                if (state is LoadingMoreProducts)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.height * 0.015,
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                SizedBox(height: SizeConfig.height * 0.01),
              ]),
            );
          },
        );
      },
    );
  }
}
