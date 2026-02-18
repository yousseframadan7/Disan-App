import 'dart:developer';

import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_chats/models/customer_chat_model.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/chat/view_models/cubit/chat_cubit.dart';
import 'package:disan/features/chat/views/widgets/chat_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("chat screen");
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    var customerChatModel = CustomerChatModel.fromJson(arguments);
    log(customerChatModel.toJson().toString());
    return BlocProvider(
      create: (context) => ChatCubit(id: customerChatModel.id,shopId: customerChatModel.shopId,customerId: customerChatModel.customerId),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatFailed) {
            return Scaffold(
                body: CustomFailureMesage(errorMessage: state.error));
          }
          if (state is ChatLoading) {
            return Scaffold(body: CustomLoading());
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.kPrimaryColor,
              foregroundColor: Colors.white,
              titleSpacing: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundImage:
                          NetworkImage(customerChatModel.customer!.image),
                      radius: SizeConfig.width * 0.05),
                  SizedBox(width: SizeConfig.width * 0.02),
                  Expanded(
                    child: Text(
                      customerChatModel.customer!.name,
                      style: AppTextStyles.title20WhiteW500,
                    ),
                  ),
                ],
              ),
              actions: [
                CustomIconButton(
                  icon: Icons.call,
                  iconSize: SizeConfig.width * 0.06,
                  onPressed: () {
                    showToast("Comming soon");
                  },
                ),
                CustomIconButton(
                    icon: Icons.video_call,
                    iconSize: SizeConfig.width * 0.08,
                    onPressed: () {
                      showToast("Comming soon");
                    }),
                SizedBox(width: SizeConfig.width * 0.02),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.04,
                  vertical: SizeConfig.height * 0.01,
                ),
                decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage(AppImages.chatBackgroundImage),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: ChatScrrenBody()),
          );
        },
      ),
    );
  }
}