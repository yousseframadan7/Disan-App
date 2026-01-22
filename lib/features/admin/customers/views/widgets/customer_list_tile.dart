import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_chats/models/customer_chat_model.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerListTile extends StatelessWidget {
  const CustomerListTile({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushScreen(RouteNames.customerDetailsScreen,
            arguments: userModel.toJson());
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppColors.kPrimaryColor,
            width: 2,
          )),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userModel.image),
      ),
      tileColor: AppColors.kPrimaryColor.withOpacity(0.5),
      title: Text(
        userModel.name,
        style: AppTextStyles.title18WhiteBold,
      ),
      subtitle: Text(userModel.email, style: AppTextStyles.title14White),
      trailing: IconButton(
        icon: Icon(
          CupertinoIcons.chat_bubble,
          color: Colors.white,
        ),
        onPressed: () {
          context.pushScreen(RouteNames.chatScreen,
              arguments: CustomerChatModel(
                  customer: CustomerModel.fromJson(userModel.toJson()),
                  id: getIt<SupabaseClient>().auth.currentUser!.id +
                      userModel.id,
                  shopId: getIt<SupabaseClient>().auth.currentUser!.id,
                  customerId: userModel.id,
                  messages: []).toJson());
        },
      ),
    );
  }
}
