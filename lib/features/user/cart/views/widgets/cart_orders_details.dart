import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/components/custom_text_form_field.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/cart/models/cart_model.dart';
import 'package:disan/features/user/cart/view_models/cubit/order_product_cubit.dart';
import 'package:disan/features/user/cart/views/widgets/order_info_row.dart';
import 'package:disan/features/user/cart/views/widgets/swipeable_button.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartOrdersDetails extends StatelessWidget {
  const CartOrdersDetails({
    super.key,
    required this.carts,
  });

  final List<CartItemModel> carts;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.03,
        vertical: SizeConfig.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.width * 0.07),
          topRight: Radius.circular(SizeConfig.width * 0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            hintText: "enter your coupon code",
            fillColor: Colors.white,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          Text(
            LocaleKeys.order_summary.tr(),
            style: AppTextStyles.title20BlackW500,
          ),
          OrderInfoRow(
            title: "${LocaleKeys.items.tr()} :",
            value: carts.fold(0, (sum, item) => sum + item.quantity).toString(),
          ),
          OrderInfoRow(
            title: "${LocaleKeys.subtotal.tr()} :",
            value:
                "${LocaleKeys.le.tr()} ${carts.fold(0.0, (sum, item) => sum + (item.quantity * item.product.price)).toStringAsFixed(2)}",
          ),
          OrderInfoRow(
            title: "${LocaleKeys.discount.tr()} :",
            value: "${LocaleKeys.le.tr()} 0",
          ),
          OrderInfoRow(
            title: "${LocaleKeys.delivery_charges.tr()} :",
            value: "${LocaleKeys.le.tr()} 200",
          ),
          Divider(),
          OrderInfoRow(
            title: "${LocaleKeys.total.tr()} :",
            value:
                "${LocaleKeys.le.tr()}${(carts.fold(0.0, (sum, item) => sum + (item.quantity * item.product.price)) + 200).toStringAsFixed(2)}",
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          BlocBuilder<OrderProductCubit, OrderProductState>(
            builder: (context, state) {
              if (state is OrderProductLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              return SwipeableButton(
                onSwipeComplete: () {
                  context.read<OrderProductCubit>().orderProducts();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
