// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class AdminBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
      ),
      child: ResponsiveNavigationBar(
        selectedIndex: currentIndex,
        onTabChange: onTap,
        textStyle: AppTextStyles.title16WhiteBold,
        backgroundOpacity: 0.0,
        navigationBarButtons: [
          NavigationBarButton(
            text: LocaleKeys.home.tr(),
            icon: Icons.home_rounded,
            backgroundGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.15),
                AppColors.kPrimaryColor,
              ],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.my_products.tr(),
            icon: Icons.inventory_2_rounded,
            backgroundGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.15),
                AppColors.kPrimaryColor,
              ],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.my_requests.tr(),
            icon: Icons.inbox_rounded,
            backgroundGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.15),
                AppColors.kPrimaryColor,
              ],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.chats.tr(),
            icon: Icons.chat_bubble_rounded,
            backgroundGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.15),
                AppColors.kPrimaryColor,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
