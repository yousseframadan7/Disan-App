import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_details/views/widgets/customer_info_tile.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerDetailsScreenBody extends StatelessWidget {
  const CustomerDetailsScreenBody({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.02,
              vertical: SizeConfig.height * 0.01,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                userModel.image,
                height: SizeConfig.height * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.02,
            ),
            child: Column(
              children: [
                CustomerInfoTile(
                  value: userModel.name,
                  title: LocaleKeys.customer_name.tr(),
                  icon: CupertinoIcons.person,
                ),
                SizedBox(height: SizeConfig.height * 0.01),
                CustomerInfoTile(
                  value: userModel.phone,
                  title: LocaleKeys.customer_phone.tr(),
                  icon: CupertinoIcons.phone,
                ),
                SizedBox(height: SizeConfig.height * 0.01),
                CustomerInfoTile(
                  value: userModel.email,
                  title: LocaleKeys.customer_email.tr(),
                  icon: Icons.email_outlined,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
