import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_requests/models/customer_request_model.dart';
import 'package:disan/features/admin/customer_requests/view_models/cubit/get_customer_requests_cubit.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CustomerRequestListTile extends StatelessWidget {
  const CustomerRequestListTile({
    super.key,
    required this.customerRequests,
  });

  final CustomerRequestModel customerRequests;

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
      itemBuilder: (context) => [
        PullDownMenuItem(
          title: LocaleKeys.processing.tr(),
          onTap: () {
            context
                .read<GetCustomerRequestsCubit>()
                .updateCustomerRequestStatus(
                  requestId: customerRequests.id,
                  status: "processing",
                  user: customerRequests.user!,
                );
          },
          icon: Icons.hourglass_bottom_sharp,
          iconColor: Colors.amber,
        ),
        PullDownMenuItem(
          title: LocaleKeys.shipped.tr(),
          onTap: () {
            context
                .read<GetCustomerRequestsCubit>()
                .updateCustomerRequestStatus(
                  requestId: customerRequests.id,
                  status: "shipped",
                  user: customerRequests.user!,
                );
          },
          icon: Icons.delivery_dining_outlined,
          iconColor: AppColors.kPrimaryColor,
        ),
        PullDownMenuItem(
          title: LocaleKeys.delivered.tr(),
          onTap: () {
            context
                .read<GetCustomerRequestsCubit>()
                .updateCustomerRequestStatus(
                  requestId: customerRequests.id,
                  status: "delivered",
                  user: customerRequests.user!,
                );
          },
          icon: Icons.done,
          iconColor: Colors.green,
        ),
        PullDownMenuItem(
          title: LocaleKeys.rejected.tr(),
          onTap: () {
            context
                .read<GetCustomerRequestsCubit>()
                .deleteCustomerRequest(
                  requestId: customerRequests.id,
                  status: LocaleKeys.rejected.tr(),
                  user: customerRequests.user!,
                );
          },
          isDestructive: true,
          icon: Icons.close,
          iconColor: Colors.red,
        ),
      ],
      buttonBuilder: (context, showMenu) => Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.height * 0.01,
        ),
        child: ListTile(
          onTap: () {
            context.pushScreen(
              RouteNames.customerRequestsDetailsScreen,
              arguments: customerRequests.id,
            );
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.kPrimaryColor, width: 1.5)),
          leading: CircleAvatar(
              radius: SizeConfig.width * 0.1,
              backgroundImage: NetworkImage(customerRequests.user!.image)),
          title: Text(
            customerRequests.user!.name,
            style: AppTextStyles.title16PrimaryColorW500,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${customerRequests.totalAmount} ${LocaleKeys.le.tr()}",
                style: AppTextStyles.title16Grey,
              ),
              Text(
                "${customerRequests.user?.phone}",
                style: AppTextStyles.title16Grey,
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              CupertinoIcons.ellipsis_circle,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () => showMenu(),
          ),
        ),
      ),
    );
  }
}
