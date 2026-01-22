import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_requests/view_models/cubit/get_customer_requests_cubit.dart';
import 'package:disan/features/admin/customer_requests/views/widgets/custom_tab_bar.dart';
import 'package:disan/features/admin/customer_requests/views/widgets/customer_requests_tab_bar_view.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class CustommerRequestsScreenBody extends StatelessWidget {
  const CustommerRequestsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCustomerRequestsCubit(),
      child: BlocConsumer<GetCustomerRequestsCubit, GetCustomerRequestsState>(
        listener: (context, state) {
          if (state is UpdateCustomerRequestStatus) {
            context.popScreen();
            quickAlert(
              type: QuickAlertType.success,
              text:
                  "${LocaleKeys.request.tr()} ${state.userName} ${LocaleKeys.is_changed_to.tr()} ${state.status} ${LocaleKeys.successfully.tr()}",
              title: LocaleKeys.success.tr(),
            );
          }
          if (state is DeleteCustomerRequestSuccess) {
            context.popScreen();
            quickAlert(
              type: QuickAlertType.success,
              text:
                  "${LocaleKeys.request.tr()} ${state.userName} ${LocaleKeys.is_removed.tr()}",
              title: LocaleKeys.success.tr(),
            );
          }

          if (state is UpdateCustomerRequestLoading) {
            quickAlert(
              type: QuickAlertType.loading,
              title: LocaleKeys.loading.tr(),
            );
          }
          if (state is UpdateCustomerRequestFailure) {
            context.popScreen();
            quickAlert(
              type: QuickAlertType.error,
              text: state.message,
              title: LocaleKeys.failure.tr(),
            );
          }
        },
        builder: (context, state) {
          if (state is GetCustomerRequestsLoading) {
            return CustomLoading();
          }
          if (state is GetCustomerRequestsFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          var cubit = context.read<GetCustomerRequestsCubit>();
          return SafeArea(
            child: DefaultTabController(
              length: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.04,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.height * 0.02),
                    CustomTabBar(tabs: [
                      LocaleKeys.pending.tr(),
                      LocaleKeys.processing.tr(),
                      LocaleKeys.shipped.tr(),
                      LocaleKeys.delivered.tr()
                    ]),
                    SizedBox(height: SizeConfig.height * 0.03),
                    CustomerRequestsTabBarView(cubit: cubit)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
