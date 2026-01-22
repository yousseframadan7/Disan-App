import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_chats/models/customer_chat_model.dart';
import 'package:disan/features/admin/customer_chats/views/widgets/space_with_divider.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerChatListTile extends StatelessWidget {
  const CustomerChatListTile({
    super.key,
    required this.chatItem,
  });

  final CustomerChatModel chatItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor,
                AppColors.kPrimaryColor.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.02,
                vertical: SizeConfig.height * 0.01),
            leading: CircleAvatar(
              radius: SizeConfig.width * 0.1,
              backgroundImage: NetworkImage(
                chatItem.customer?.image ?? "",
              ),
            ),
            title: Text(
              chatItem.customer?.name ?? "",
              style: AppTextStyles.title18WhiteW500,
            ),
            subtitle: Text(
              chatItem.messages!.isEmpty
                  ? LocaleKeys.no_messages_yet.tr()
                  : chatItem.messages?.first.message ?? LocaleKeys.no_messages_yet.tr(),
              style: AppTextStyles.title16White300,
            ),
            // trailing: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       DateHelper.formatDate(chatItem.),
            //       style: AppTextStyles.title12PrimaryColorW500,
            //     ),
            //     Text(
            //       DateHelper.formatTimeAgo(DateTime.now()),
            //       style: AppTextStyles.title12PrimaryColorW500,
            //     ),
            //   ],
            // ),
            onTap: () {
              context.pushScreen(RouteNames.chatScreen,
                  arguments: chatItem.toJson());
            },
          ),
        ),
        SpaceWithDivider(),
      ],
    );
  }
}
