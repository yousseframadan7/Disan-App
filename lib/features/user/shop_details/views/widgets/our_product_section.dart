import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/hom/views/widgets/product_card.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';

class OurProductsSection extends StatelessWidget {
  const OurProductsSection({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                var wishlistCubit = getIt<WishListCubit>();
                return ProductCard(
                  product: product,
                  isFavorite: wishlistCubit.isFavorite(product.id),
                  onTapToggleFavorite: () =>
                      wishlistCubit.toggleFavorite(product.id),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
