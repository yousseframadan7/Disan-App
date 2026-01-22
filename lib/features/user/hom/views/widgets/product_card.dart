// ignore_for_file: library_private_types_in_public_api
import 'package:disan/core/components/translate_text.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTapToggleFavorite,
    required this.isFavorite,
  });
  final ProductModel product;
  final void Function() onTapToggleFavorite;
  final bool isFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushScreen(RouteNames.productDetailsScreen,
            arguments: product.toJson());
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.02,
          vertical: SizeConfig.height * 0.008,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 2,
            ),
          ],
          border: Border.all(color: AppColors.kPrimaryColor, width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<WishListCubit, WishListState>(
                      buildWhen: (previous, current) => current is ToggleFavorite,
                      builder: (context, state) {
                        return Positioned(
                          top: SizeConfig.height * 0.005,
                          right: SizeConfig.width * 0.015,
                          child: GestureDetector(
                            onTap: onTapToggleFavorite,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width * 0.01,
                                vertical: SizeConfig.height * 0.01,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.9),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: isFavorite
                                    ? AppColors.kSecondaryColor
                                    : Colors.grey,
                                size: SizeConfig.width * 0.05,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Price Tag
                    Positioned(
                      bottom: SizeConfig.height * 0.005,
                      right: SizeConfig.width * 0.005,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width * 0.015,
                          vertical: SizeConfig.height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                            "${product.price.toStringAsFixed(2)} ${LocaleKeys.le.tr()}",
                            style: AppTextStyles.title12WhiteW500),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.02,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslateText(
                      text: product.name,
                      style: AppTextStyles.title18BlackBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TranslateText(
                      text: product.description,
                      style: AppTextStyles.title12BlackColorW400,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_outline_rounded,
                          color: Colors.amber.shade700,
                          size: SizeConfig.width * 0.05,
                        ),
                        SizedBox(width: SizeConfig.width * 0.01),
                        Text(
                          '(4.5)',
                          style: AppTextStyles.title14BlackColorW400,
                        ),
                        const Spacer(),
                        Text(
                          "(2.2)",
                          style: AppTextStyles.title14BlackBold,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
