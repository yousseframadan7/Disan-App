import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/profile/views/widgets/profile_list_tile.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userModel = getIt<CacheHelper>().getUserModel();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.03,
          vertical: SizeConfig.height * 0.01,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    userModel!.image,
                  ),
                  radius: SizeConfig.width * 0.15,
                ),
                SizedBox(height: SizeConfig.height * 0.01),
                Text(
                  userModel.name,
                  style: AppTextStyles.title24BlackBold,
                ),
                Text(
                  userModel.email,
                  style: AppTextStyles.title16Grey,
                ),
                SizedBox(height: SizeConfig.height * 0.035),
                ProfileListTile(
                  lable: LocaleKeys.profile.tr(),
                  route: RouteNames.profileDetailsScreen,
                  icon: Icons.person,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                GestureDetector(
                  child: ProfileListTile(
                    lable: LocaleKeys.settings.tr(),
                    route: RouteNames.settingsScreen,
                    icon: Icons.settings,
                  ),
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                ProfileListTile(
                  lable: LocaleKeys.contact_support.tr(),
                  icon: Icons.contacts_outlined,
                  route: RouteNames.contactSupportScreen,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                getIt<CacheHelper>().getUserModel()!.role == 'customer'
                    ? Column(
                        children: [
                          ProfileListTile(
                            lable: LocaleKeys.my_orders.tr(),
                            icon: Icons.list_alt_outlined,
                            route: RouteNames.myOrdersScreen,
                          ),
                          SizedBox(height: SizeConfig.height * 0.015),
                        ],
                      )
                    : SizedBox(),
                ProfileListTile(
                  lable: LocaleKeys.share_app.tr(),
                  icon: Icons.share,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                ProfileListTile(
                  lable: LocaleKeys.about.tr(),
                  icon: Icons.help_outline_outlined,
                  route: RouteNames.aboutScreen,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                CustomElevatedButton(
                  name: LocaleKeys.logout.tr(),
                  backgroundColor: AppColors.kSecondaryColor,
                  onPressed: () async {
                    await getIt<SupabaseClient>().auth.signOut();
                    await getIt<CacheHelper>().removeData(key: "user");
                    context
                        .pushAndRemoveUntilScreen(RouteNames.selectRoleScreen);
                  },
                ),
                SizedBox(height: SizeConfig.height * 0.09),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
