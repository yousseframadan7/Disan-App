import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/user/hom/views/widgets/product_map_card.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/get_all_products/cubit/get_all_products_cubit.dart';
import 'package:disan/features/get_all_products/cubit/get_all_products_state.dart';
import 'package:disan/core/app_route/route_names.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetAllProductsCubit()..fetchAllProducts(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.04,
                  vertical: SizeConfig.height * 0.015,
                ),
                child: SizedBox(
                  height: SizeConfig.height * 0.06,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        'All Products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: BlocBuilder<GetAllProductsCubit, GetAllProductsState>(
                  builder: (context, state) {
                    if (state is GetAllProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is GetAllProductsLoaded) {
                      final products = state.products;

                      if (products.isEmpty) {
                        return const Center(child: Text('No products found.'));
                      }

                      return BlocBuilder<WishListCubit, WishListState>(
                        builder: (context, wishState) {
                          final wishListCubit = context.read<WishListCubit>();

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.width * 0.02,
                            ),
                            child: GridView.builder(
                              itemCount: products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.65,
                                  ),
                              itemBuilder: (context, index) {
                                final product = products[index];
                                final productId = product['id'];

                                return ProductMapCard(
                                  product: product,
                                  isFavorite: wishListCubit.isFavorite(
                                    productId,
                                  ),
                                  onTapToggleFavorite: () {
                                    wishListCubit.toggleFavorite(productId);
                                  },
                                  onPressedCard: () {
                                    context.pushScreen(
                                      RouteNames.productDetailsScreen,
                                      arguments: product,
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    }

                    if (state is GetAllProductsError) {
                      return Center(child: Text(state.errorMessage));
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
