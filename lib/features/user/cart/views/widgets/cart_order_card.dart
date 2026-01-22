import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/cart/models/cart_model.dart';
import 'package:disan/features/user/cart/view_models/cubit/order_product_cubit.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartOrderCard extends StatelessWidget {
  const CartOrderCard({
    super.key,
    required this.cart,
    required this.orderProductCubit,
  });

  final CartItemModel cart;
  final OrderProductCubit orderProductCubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height * 0.17,
      margin: EdgeInsets.only(bottom: SizeConfig.height * 0.01),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.4),
        border: Border.all(color: AppColors.kPrimaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.width * 0.02,
          right: SizeConfig.width * 0.01,
          top: SizeConfig.height * 0.005,
          bottom: SizeConfig.height * 0.005,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: SizeConfig.width * 0.3,
                height: SizeConfig.height * 0.13,
                child: Image.network(
                  cart.product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.width * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cart.product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.title18BlackW600,
                            ),
                            Text(
                              cart.product.category.toString(),
                              maxLines: 1,
                              style: AppTextStyles.title14Black,
                            ),
                            Text(
                              "${LocaleKeys.le.tr()} ${cart.product.price.toStringAsFixed(2)}",
                              style: AppTextStyles.title16White400,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width * 0.01,
                          vertical: SizeConfig.height * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            CustomIconButton(
                              icon: Icons.remove,
                              iconColor: AppColors.kPrimaryColor,
                              iconSize: SizeConfig.width * 0.05,
                              onPressed: () {
                                context
                                    .read<OrderProductCubit>()
                                    .decreaseQuantity(id: cart.product.id);
                              },
                            ),
                            SizedBox(width: SizeConfig.width * 0.01),
                            Text(cart.quantity.toString()),
                            SizedBox(width: SizeConfig.width * 0.01),
                            CustomIconButton(
                              icon: Icons.add,
                              iconColor: AppColors.kPrimaryColor,
                              iconSize: SizeConfig.width * 0.05,
                              onPressed: () {
                                context
                                    .read<OrderProductCubit>()
                                    .increaseQuantity(id: cart.product.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
