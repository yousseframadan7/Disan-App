import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/user/hom/views/widgets/product_card.dart';
import 'package:disan/features/user/shop_products/view_models/cubit/get_shop_products_cubit.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ShopProductsScreenBody extends StatelessWidget {
  const ShopProductsScreenBody({
    super.key,
    required this.shopId,
  });
  final String shopId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetShopProductsCubit(shopId: shopId),
      child: BlocBuilder<GetShopProductsCubit, GetShopProductsState>(
        builder: (context, state) {
          if (state is GetShopProductsLoading) {
            return CustomLoading();
          }
          if (state is EmptyShopProducts) {
            return Center(child: Lottie.asset(AppLotties.emptyRequestsLottie));
          }

          if (state is GetShopProductsFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          var products = context.read<GetShopProductsCubit>().products;
          var wishlistCubit = getIt<WishListCubit>();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                isFavorite: wishlistCubit.isFavorite(product.id),
                onTapToggleFavorite: () =>
                    wishlistCubit.toggleFavorite(product.id),
                product: product,
              );
            },
          );
        },
      ),
    );
  }
}
