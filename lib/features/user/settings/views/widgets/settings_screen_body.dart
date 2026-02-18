import 'package:disan/app/cubit/localization_cubit.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/profile/views/widgets/profile_list_tile.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: CustomIconButton(
          icon: Icons.arrow_back_ios,
          iconColor: Colors.black,
          iconSize: SizeConfig.width * 0.06,
          onPressed: () => context.popScreen(),
        ),
        title: Text(
          LocaleKeys.settings.tr(),
          style: AppTextStyles.title18BlackBold,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.05,
            vertical: SizeConfig.height * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.locale.languageCode == 'ar'
                    ? "أللغه العربيه"
                    : "English",
                style: AppTextStyles.title16BlackBold.copyWith(
                  color: AppColors.kPrimaryColor,
                ),
              ),

              SizedBox(height: SizeConfig.height * 0.02),
              _AnimatedTile(child: _LanguageSelectionTile()),
              SizedBox(height: SizeConfig.height * 0.02),
              GestureDetector(
                onTap: () {
                  context.pushScreen(RouteNames.privacy);
                },
                child: _AnimatedTile(
                  child: ProfileListTile(
                    onTap: () {
                      context.pushScreen(RouteNames.privacy);
                    },
                    lable: LocaleKeys.Privacy.tr(),
                    icon: Icons.privacy_tip_outlined,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.02),
              // Help Center tile
              _AnimatedTile(
                child: ProfileListTile(
                  lable: LocaleKeys.help_center.tr(),
                  icon: Icons.help_outline_outlined,
                  onTap: () {
                    context.pushScreen(RouteNames.helpCenter);
                  },
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.02),
              // About tile
              _AnimatedTile(
                child: ProfileListTile(
                  lable: LocaleKeys.About.tr(),
                  icon: Icons.info_outline,
                  onTap: () {
                    context.pushScreen(RouteNames.aboutScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for animated tile with scale effect
class _AnimatedTile extends StatefulWidget {
  final Widget child;

  const _AnimatedTile({required this.child});

  @override
  _AnimatedTileState createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<_AnimatedTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

// Widget for language selection
class _LanguageSelectionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLanguage = context
        .watch<TranslationCubit>()
        .state
        .languageCode;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(SizeConfig.width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: SizeConfig.width * 0.005,
            blurRadius: SizeConfig.width * 0.01,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => _showLanguageBottomSheet(context),
        leading: Icon(
          Icons.language,
          color: AppColors.kPrimaryColor,
          size: SizeConfig.width * 0.07,
        ),
        title: Text(
          LocaleKeys.Language.tr(),
          style: AppTextStyles.title16BlackBold,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentLanguage == 'en' ? 'English' : 'العربية',
              style: AppTextStyles.title14Grey,
            ),
            SizedBox(width: SizeConfig.width * 0.02),
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.kPrimaryColor,
              size: SizeConfig.width * 0.06,
            ),
          ],
        ),
      ),
    );
  }

  // Show bottom sheet for language selection
  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SizeConfig.width * 0.05),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.05,
          vertical: SizeConfig.height * 0.025,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.select_language.tr(),
              style: AppTextStyles.title16BlackBold,
            ),
            SizedBox(height: SizeConfig.height * 0.02),
            ListTile(
              leading: Icon(
                Icons.language,
                color: AppColors.kPrimaryColor,
                size: SizeConfig.width * 0.06,
              ),
              title: Text('English', style: AppTextStyles.title14Black),
              trailing:
                  context.watch<TranslationCubit>().state.languageCode == 'en'
                  ? Icon(
                      Icons.check_circle,
                      color: AppColors.kPrimaryColor,
                      size: SizeConfig.width * 0.06,
                    )
                  : null,
              onTap: () async {
                await context.read<TranslationCubit>().changeLanguage(
                  context,
                  'en',
                );
                context.popScreen();
                context.pushAndRemoveUntilScreen(RouteNames.homeScreen);
                quickAlert(
                  type: QuickAlertType.success,
                  title: LocaleKeys.change_language.tr(),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: AppColors.kPrimaryColor,
                size: SizeConfig.width * 0.06,
              ),
              title: Text('العربية', style: AppTextStyles.title14Black),
              trailing:
                  context.watch<TranslationCubit>().state.languageCode == 'ar'
                  ? Icon(
                      Icons.check_circle,
                      color: AppColors.kPrimaryColor,
                      size: SizeConfig.width * 0.06,
                    )
                  : null,
              onTap: () async {
                await context.read<TranslationCubit>().changeLanguage(
                  context,
                  'ar',
                );
                context.popScreen();
                context.pushAndRemoveUntilScreen(RouteNames.homeScreen);
                quickAlert(
                  type: QuickAlertType.success,
                  title: LocaleKeys.change_language.tr(),
                );
              },
            ),
            SizedBox(height: SizeConfig.height * 0.015),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => context.popScreen(),
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: AppTextStyles.title14Grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
