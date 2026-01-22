import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AdminSpeedDial extends StatelessWidget {
  const AdminSpeedDial({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: Colors.white,
      icon: Icons.menu,
      direction: SpeedDialDirection.up,
      activeIcon: Icons.close,
      spaceBetweenChildren: SizeConfig.width * 0.02,
      spacing: SizeConfig.width * 0.02,
      children: [
        buildSpeedDialChild(
          icon: Icons.person,
          title: LocaleKeys.profile.tr(),
          onPressed: () => context.pushScreen(RouteNames.profileScreen),
        ),
        buildSpeedDialChild(
          icon: Icons.interpreter_mode_rounded,
          title: LocaleKeys.customers.tr(),
          onPressed: () => showToast('Coming soon'),
        ),
        buildSpeedDialChild(
          icon: Icons.add,
          title: '${LocaleKeys.add_product.tr()} & ${LocaleKeys.add_category.tr()}',
          onPressed: () =>
              context.pushScreen(RouteNames.addProductAndCategoryScreen),
        ),
        buildSpeedDialChild(
          icon: Icons.discount_outlined,
          title: LocaleKeys.offers.tr(),
          onPressed: (){
            context.pushScreen(RouteNames.offersScreen);
          },
        ),
      ],
    );
  }

  buildSpeedDialChild({
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return SpeedDialChild(
      child: Icon(icon),
      label: title,
      labelStyle: AppTextStyles.title16PrimaryColorW500,
      onTap: onPressed,
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: Colors.white,
      labelBackgroundColor: Colors.white,
    );
  }
}
