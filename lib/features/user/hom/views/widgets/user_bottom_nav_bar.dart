import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class UserBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const UserBottomNavBar({
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
        backgroundOpacity: 0.05,
        backgroundColor: AppColors.kPrimaryColor,
        navigationBarButtons: [
          NavigationBarButton(
            text: LocaleKeys.home.tr(),
            icon: Icons.home,
            backgroundGradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.15), AppColors.kPrimaryColor],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.wishlist.tr(),
            icon: Icons.favorite,
            backgroundGradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.15), AppColors.kPrimaryColor],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.Notifications.tr(),
            icon: Icons.notifications_none,
            backgroundGradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.15), AppColors.kPrimaryColor],
            ),
          ),
          NavigationBarButton(
            text: LocaleKeys.profile.tr(),
            icon: Icons.person,
            backgroundGradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.15), AppColors.kPrimaryColor],
            ),
          ),
        ],
      ),
    );
  }
}
