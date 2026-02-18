import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/product_details/view_model/cubit/add_to_cart_cubit.dart';
import 'package:disan/features/user/product_details/views/widgets/custom_circle_progress_indecator.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductActions extends StatelessWidget {
  const ProductActions({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCartCubit, AddToCartState>(
      builder: (context, state) {
        var cubit = context.read<AddToCartCubit>();
        return getIt<CacheHelper>().getUserModel()!.role == 'customer'
            ? Row(
                children: [
                  Column(
                    children: [
                      Text(
                        "Total Price",
                        style: AppTextStyles.title20PrimaryColorW500,
                      ),
                      BlocBuilder<AddToCartCubit, AddToCartState>(
                        buildWhen: (previous, current) =>
                            current is UpdateQuantity,
                        builder: (context, state) {
                          return Text(
                            "${product.price * cubit.quantity} LE",
                            style: AppTextStyles.title16Black,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConfig.width * 0.1),
                  Expanded(
                    child: BlocBuilder<AddToCartCubit, AddToCartState>(
                      buildWhen: (previous, current) =>
                          current is AddToCartLoading,
                      builder: (context, state) {
                        if (state is AddToCartLoading) {
                          return const CustomCircleProgressIndecator();
                        }
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.kPrimaryColor
                                .withOpacity(0.8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(36),
                                bottomLeft: Radius.circular(36),
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            minimumSize: Size(
                              double.infinity,
                              SizeConfig.height * 0.07,
                            ),
                          ),
                          child: Text(
                            LocaleKeys.add_to_cart.tr(),
                            style: AppTextStyles.title18WhiteBold,
                          ),
                          onPressed: () => cubit.addToCart(product: product),
                        );
                      },
                    ),
                  ),
                ],
              )
            : getIt<CacheHelper>().getUserModel()!.role == 'shop' &&
                  getIt<SupabaseClient>().auth.currentUser!.id == product.shopId
            ? Column(
                children: [
                  BlocBuilder<AddToCartCubit, AddToCartState>(
                    buildWhen: (previous, current) =>
                        current is DeleteProductLoading,
                    builder: (context, state) {
                      if (state is DeleteProductLoading) {
                        return const CustomCircleProgressIndecator();
                      }
                      return _buildAnimatedButton(
                        context,
                        LocaleKeys.delete_product.tr(),
                        () => showToast("Coming soon"),
                        Colors.red,
                      );
                    },
                  ),
                  BlocBuilder<AddToCartCubit, AddToCartState>(
                    buildWhen: (previous, current) =>
                        current is UpdateProductLoading,
                    builder: (context, state) {
                      if (state is UpdateProductLoading) {
                        return const CustomCircleProgressIndecator();
                      }
                      return _buildAnimatedButton(
                        context,
                        LocaleKeys.edit_product.tr(),
                        () {
                          context.pushScreen(
                            RouteNames.editProductScreen,
                            arguments: product.toJson(),
                          );
                        },
                        AppColors.kPrimaryColor.withOpacity(0.8),
                      );
                    },
                  ),
                ],
              )
            : Container();
      },
    );
  }

  Widget _buildAnimatedButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.04,
        vertical: SizeConfig.height * 0.01,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: SizeConfig.width * 0.045,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
