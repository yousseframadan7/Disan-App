import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/admin/customers/view_models/cubit/get_customers_cubit.dart';
import 'package:disan/features/admin/customers/views/widgets/customers_list_view.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CustomersScreenBody extends StatelessWidget {
  const CustomersScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: BlocProvider(
          create: (context) => GetCustomersCubit(),
          child: BlocBuilder<GetCustomersCubit, GetCustomersState>(
            builder: (context, state) {
              if (state is GetCustomersLoading) {
                return CustomLoading();
              }
              if (state is GetCustomersFailure) {
                return CustomFailureMesage(errorMessage: state.message);
              }
              if (state is NoCustomersExist) {
                return Center(
                    child: Lottie.asset(AppLotties.noCustomersExistLottie));
              }
              var cubit = context.read<GetCustomersCubit>();
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width * 0.04,
                      vertical: SizeConfig.height * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onPressed: () => context.popScreen(),
                        ),
                        Text(
                          LocaleKeys.customers.tr(),
                          style: AppTextStyles.title22WhiteColorBold.copyWith(
                            letterSpacing: 1.2,
                          ),
                        ),
                        CustomIconButton(
                          icon: Icons.stacked_bar_chart_rounded,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.height * 0.01),
                  CustomerListView(cubit: cubit),
                ],
              );
            },
          ),
      ),
    );
  }
}
