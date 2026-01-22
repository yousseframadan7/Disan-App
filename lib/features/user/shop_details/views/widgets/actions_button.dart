import 'dart:developer';

import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/circle_icon_button.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_chats/models/customer_chat_model.dart';
import 'package:disan/features/user/shop_products/models/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key, required this.shopModel});
  final ShopModel shopModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              name: 'Follow',
              onPressed: () {
                showToast('Coming soon');
              },
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(width: SizeConfig.width * 0.03),
          CircleIconButton(
            backgroundColor: Colors.green,
            iconColor: Colors.white,
            icon: Icons.phone,
            onPressed: () {
              showToast('Coming soon');
            },
          ),
          SizedBox(width: SizeConfig.width * 0.02),
          CircleIconButton(
            backgroundColor: Colors.grey.shade300,
            iconColor: Colors.black,
            icon: CupertinoIcons.chat_bubble,
            onPressed: () {
              log(getIt<SupabaseClient>().auth.currentUser!.id);
              log(shopModel.id);
              context.pushScreen(RouteNames.chatScreen,
                  arguments: CustomerChatModel(
                    id: shopModel.id +
                        getIt<SupabaseClient>().auth.currentUser!.id,
                    customerId: getIt<SupabaseClient>().auth.currentUser!.id,
                    shopId: shopModel.id,
                    customer: CustomerModel(
                      name: shopModel.name,
                      image: shopModel.image,
                    ),
                  ).toJson());
            },
          ),
        ],
      ),
    );
  }
}
