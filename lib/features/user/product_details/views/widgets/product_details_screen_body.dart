import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/user/product_details/views/widgets/shop_info.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:lottie/lottie.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/product_details/view_model/cubit/add_to_cart_cubit.dart';
import 'package:disan/features/user/product_details/views/widgets/product_actions.dart';
import 'package:disan/features/user/product_details/views/widgets/product_image_and_quantity.dart';
import 'package:disan/features/user/product_details/views/widgets/product_info.dart';
import 'package:disan/features/user/product_details/views/widgets/reviews_list_view.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailsScreenBody extends StatelessWidget {
  const ProductDetailsScreenBody({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => AddToCartCubit(id: product.id),
        child: BlocListener<AddToCartCubit, AddToCartState>(
          listenWhen: (previous, current) {
            return current is! UpdateProductLoading &&
                current is! AddToCartLoading &&
                current is! DeleteProductLoading &&
                current is! RemoveFromCartLoading;
          },
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (!context.mounted) return;
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) {
                    Future.delayed(const Duration(seconds: 2), () {
                      if (dialogContext.mounted) {
                        context.popScreen();
                      }
                    });
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset(
                            AppLotties.shoppingCart,
                            width: SizeConfig.width * 0.5,
                            height: SizeConfig.width * 0.5,
                            repeat: false,
                          ),
                          SizedBox(height: SizeConfig.height * 0.02),
                          Text(
                            LocaleKeys.product_added_to_cart_successfully.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ).then((_) {
                  if (context.mounted) {
                    context.popScreen();
                    quickAlert(
                      type: QuickAlertType.success,
                      text: LocaleKeys.product_added_to_cart_successfully.tr(),
                    );
                  }
                });
              });
            }
            if (state is UpdateProductSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.popScreen();
                  quickAlert(
                    type: QuickAlertType.success,
                    text: LocaleKeys.product_updated_successfully.tr(),
                    title: LocaleKeys.success.tr(),
                  );
                }
              });
            }
            if (state is DeleteProductSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.popScreen();
                  quickAlert(
                    type: QuickAlertType.success,
                    text: LocaleKeys.product_deleted_successfully.tr(),
                    title: LocaleKeys.success.tr(),
                  );
                }
              });
            }
            if (state is AddToCartFailure) {
              quickAlert(
                type: QuickAlertType.error,
                text: state.message,
                title: LocaleKeys.error.tr(),
              );
            }
            if (state is DeleteProductFailure) {
              quickAlert(
                type: QuickAlertType.error,
                text: state.message,
                title: LocaleKeys.error.tr(),
              );
            }
            if (state is UpdateProductFailure) {
              quickAlert(
                type: QuickAlertType.error,
                text: state.message,
                title: LocaleKeys.error.tr(),
              );
            }
            if (state is ProductExistsInCart) {
              quickAlert(
                type: QuickAlertType.info,
                text: state.message,
                title: LocaleKeys.info.tr(),
              );
            }
            if (state is RemoveFromCartSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.popScreen();
                  quickAlert(
                    type: QuickAlertType.success,
                    text: LocaleKeys.remoce_successfully.tr(),
                    title: LocaleKeys.success.tr(),
                  );
                }
              });
            }
            if (state is RemoveFromCartFailure) {
              quickAlert(
                type: QuickAlertType.error,
                text: state.message,
                title: LocaleKeys.error.tr(),
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageAndQuantity(image: product.image),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width * 0.04,
                        ),
                        child: Column(
                          children: [
                            ProductInfo(product: product),
                            SizedBox(height: SizeConfig.height * 0.02),
                            ShopInfo(
                              shopName: product.shopName,
                              onPressed: () {
                                context.pushScreen(
                                  RouteNames.shopDetailsScreen,
                                  arguments: product.shopId,
                                );
                              },
                            ),
                            SizedBox(height: SizeConfig.height * 0.02),
                            // ReviewsListView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              getIt<CacheHelper>().getUserModel()!.role == 'customer' ||
                      getIt<CacheHelper>().getUserModel()!.role == 'shop' &&
                          getIt<SupabaseClient>().auth.currentUser!.id ==
                              product.shopId
                  ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width * 0.02,
                        vertical: SizeConfig.height * 0.01,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width * 0.04,
                        vertical: SizeConfig.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.kPrimaryColor,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: ProductActions(product: product),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
