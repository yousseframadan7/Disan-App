import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_chats/veiw_models/cubit/get_customer_chats_cubit.dart';
import 'package:disan/features/admin/customer_chats/views/widgets/customer_chat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerChatsListView extends StatelessWidget {
  const CustomerChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<GetCustomerChatsCubit>();
    return  ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.04,
        vertical: SizeConfig.height * 0.02,
      ),
      itemCount: cubit.chats.length,
      itemBuilder: (context, index) {
        var chatItem = cubit.chats[index];
        return CustomerChatListTile(chatItem: chatItem);
      },
    );
  }
}
