import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.lable,
    this.route,
    required this.icon,
    required this.onTap,
  });
  final String lable;
  final String? route;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: AppColors.kPrimaryColor),
      title: Text(lable, style: AppTextStyles.title18BlackW500),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.kPrimaryColor,
      ),
    );
  }
}
