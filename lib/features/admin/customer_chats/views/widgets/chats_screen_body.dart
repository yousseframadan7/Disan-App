import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_chats/veiw_models/cubit/get_customer_chats_cubit.dart';
import 'package:disan/features/admin/customer_chats/views/widgets/customer_chats_list_view.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ChatsScreenBody extends StatelessWidget {
  const ChatsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => GetCustomerChatsCubit(),
        child: BlocBuilder<GetCustomerChatsCubit, GetCustomerChatsState>(
          builder: (context, state) {
            if (state is GetCustomerChatsLoading) {
              return CustomLoading();
            }
            if (state is GetCustomerChatsFailure) {
              return Text(
                state.message,
                style: AppTextStyles.title20PrimaryColorW500,
              );
            }
            if (state is EmptyCustomerChats) {
              return Center(
                child: Lottie.asset(AppLotties.emptyLottie),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.width * 0.04,
                    right: SizeConfig.width * 0.04,
                    top: SizeConfig.height * 0.02,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.chats.tr(),
                            style: AppTextStyles.title24PrimaryColorW500),
                        Icon(CupertinoIcons.chat_bubble_2,
                            color: AppColors.kPrimaryColor,
                            size: SizeConfig.width * 0.06),
                      ]),
                ),
                Expanded(child: CustomerChatsListView()),
              ],
            );
          },
        ),
      ),
    );
  }
}
