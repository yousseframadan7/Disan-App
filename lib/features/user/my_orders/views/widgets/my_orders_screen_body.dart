import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/user/my_orders/view_models/cubit/get_my_orders_cubit.dart';
import 'package:disan/features/user/my_orders/views/widgets/custom_blur_title.dart';
import 'package:disan/features/user/my_orders/views/widgets/order_card.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MyOrdersScreenBody extends StatelessWidget {
  const MyOrdersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMyOrdersCubit(),
      child: BlocBuilder<GetMyOrdersCubit, GetMyOrdersState>(
        builder: (context, state) {
          if (state is GetMyOrdersLoading) {
            return CustomLoading();
          }
          if (state is GetMyOrdersFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          if (state is EmptyOrders) {
            return Center(child: Lottie.asset(AppLotties.emptyLottie));
          }
          var cubit = context.read<GetMyOrdersCubit>();
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.02,
                vertical: SizeConfig.height * 0.01,
              ),
              child: Column(
                children: [
                  CustomPlurTitle(
                    title: LocaleKeys.my_orders.tr(),
                  ),
                  SizedBox(height: SizeConfig.height * 0.02),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: cubit.customerOrders.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          context.pushScreen(RouteNames.myOrdersDetailsScreen,
                              arguments: cubit.customerOrders[index].toJson());
                        },
                        child: OrderCard(
                          order: cubit.customerOrders[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

