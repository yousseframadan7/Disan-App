// ignore_for_file: deprecated_member_use
import 'package:flutter/cupertino.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class AdminBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AdminBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ResponsiveNavigationBar(
        selectedIndex: currentIndex,
        onTabChange: onTap,
        textStyle: AppTextStyles.title16WhiteBold,
        backgroundOpacity: 0.0,
        navigationBarButtons: [
          NavigationBarButton(
            text: LocaleKeys.home.tr(),
            icon: Icons.home,
            backgroundGradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor.withOpacity(0.5),
                AppColors.kPrimaryColor
              ],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.my_products.tr(),
            icon: Icons.propane_tank_outlined,
            backgroundGradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor.withOpacity(0.7),
                AppColors.kPrimaryColor
              ],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.my_requests.tr(),
            icon: Icons.inbox,
            backgroundGradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor.withOpacity(0.7),
                AppColors.kPrimaryColor
              ],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.chats.tr(),
            icon: CupertinoIcons.chat_bubble_2_fill,
            backgroundGradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor.withOpacity(0.7),
                AppColors.kPrimaryColor
              ],
            ),
          ),
        ],
      ),
    );
  }
}
