import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class UserHomeScreenHeader extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const UserHomeScreenHeader({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.height * 0.01,
        left: SizeConfig.width * 0.02,
        right: SizeConfig.width * 0.02,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: SizeConfig.width * 0.07,
            backgroundImage: NetworkImage(
              getIt<CacheHelper>().getUserModel()!.image,
            ),
          ),
          SizedBox(width: SizeConfig.width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.hello.tr(),
                style: AppTextStyles.title18BlackBold,
              ),
              Text(
                getIt<CacheHelper>().getUserModel()!.name,
                style: AppTextStyles.title14Black,
              ),
            ],
          ),
          Spacer(),
          CustomIconButton(
            iconSize: SizeConfig.width * 0.06,
            iconColor: Colors.white,
            onPressed: () {
              context.pushScreen(RouteNames.cartScreen);
            },
            hPadding: SizeConfig.width * 0.03,
            vPadding: SizeConfig.height * 0.03,
            backgroundColor: AppColors.kPrimaryColor,
            icon: Icons.shopping_cart_outlined,
          ),
          SizedBox(width: SizeConfig.width * 0.01),
          CustomIconButton(
            iconSize: SizeConfig.width * 0.06,
            hPadding: SizeConfig.width * 0.03,
            vPadding: SizeConfig.height * 0.03,
            backgroundColor: AppColors.kPrimaryColor,
            child: Badge(
              backgroundColor: Colors.red,
              padding: EdgeInsets.all(SizeConfig.width * 0.00),
              label: Text("2"),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              showToast('Coming soon');
            },
          ),

          SizedBox(width: SizeConfig.width * 0.01),
        ],
      ),
    );
  }
}
