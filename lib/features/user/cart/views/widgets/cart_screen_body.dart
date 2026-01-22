// ignore_for_file: deprecated_member_use
import 'package:lottie/lottie.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/cart/view_models/cubit/order_product_cubit.dart';
import 'package:disan/features/user/cart/views/widgets/cart_items_list_view.dart';
import 'package:disan/features/user/cart/views/widgets/cart_orders_details.dart';
import 'package:disan/features/user/cart/views/widgets/cart_screen_header.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CartScreenHeader(),
          Expanded(
            child: BlocProvider(
              create: (context) => OrderProductCubit(),
              child: BlocConsumer<OrderProductCubit, OrderProductState>(
                listener: (context, state) {
                  if (state is OrderProductSuccess) {
                    context.popScreen();
                    context.popScreen();
                    quickAlert(
                      type: QuickAlertType.success,
                      text: LocaleKeys.order_placed_successfully.tr(),
                      title: LocaleKeys.success.tr(),
                    );
                  }
                  if (state is OrderProductFailure) {
                    quickAlert(
                      type: QuickAlertType.error,
                      text: state.message,
                      title: LocaleKeys.error.tr(),
                    );
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<OrderProductCubit>();
                  return cubit.carts.isEmpty
                      ? Lottie.asset(AppLotties.emptyRequestsLottie)
                      : Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: SizeConfig.height * 0.005,
                                  left: SizeConfig.width * 0.03,
                                  right: SizeConfig.width * 0.03,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: SizeConfig.height * 0.01),
                                    Expanded(
                                        child: CartItemsListView(cubit: cubit)),
                                    SizedBox(height: SizeConfig.height * 0.02),
                                  ],
                                ),
                              ),
                            ),
                            CartOrdersDetails(carts: cubit.carts),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
