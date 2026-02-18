import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/user/product_details/views/widgets/reviews_list_view.dart';
import 'package:disan/features/user/shop_details/view_models/cubit/get_shop_details_cubit.dart';
import 'package:disan/features/user/shop_details/views/widgets/actions_button.dart';
import 'package:disan/features/user/shop_details/views/widgets/location_info.dart';
import 'package:disan/features/user/shop_details/views/widgets/our_product_section.dart';
import 'package:disan/features/user/shop_details/views/widgets/shop_header.dart';
import 'package:disan/features/user/shop_details/views/widgets/shop_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ShopProductsScreenBody extends StatelessWidget {
  const ShopProductsScreenBody({super.key, required this.shopId});
  final String shopId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => GetShopDetailsCubit(shopId: shopId),
            child: BlocBuilder<GetShopDetailsCubit, GetShopDetailsState>(
              builder: (context, state) {
                if (state is GetShopDetailsFailure) {
                  return CustomFailureMesage(errorMessage: state.message);
                }
                if (state is GetShopDetailsLoading) {
                  return const CustomLoading();
                }
                var shop = context.read<GetShopDetailsCubit>().shopModel!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShopHeader(
                      shopCategory: shop.category!,
                      shopImage: shop.image,
                      shopName: shop.name,
                    ),
                    SizedBox(height: SizeConfig.height * 0.01),
                    ShopInfo(description: shop.description ?? 'No description'),
                    SizedBox(height: SizeConfig.height * 0.02),
                    ActionButtons(shopModel: shop),
                    SizedBox(height: SizeConfig.height * 0.02),
                    LocationInfo(location: shop.address!),
                    SizedBox(height: SizeConfig.height * 0.02),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: SizeConfig.width * 0.04),
                    //   child: ReviewsListView(),
                    // ),
                    SizedBox(height: SizeConfig.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width * 0.04,
                      ),
                      child: Text(
                        "Our Products",
                        style: AppTextStyles.title20BlackW500,
                      ),
                    ),
                    SizedBox(height: SizeConfig.height * 0.015),
                    SizedBox(
                      height: SizeConfig.height * 0.5,
                      child: shop.products.isEmpty
                          ? Center(
                              child: Lottie.asset(
                                AppLotties.emptyRequestsLottie,
                              ),
                            )
                          : OurProductsSection(products: shop.products),
                    ),
                    SizedBox(height: SizeConfig.height * 0.02),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
