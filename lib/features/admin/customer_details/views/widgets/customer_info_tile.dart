import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomerInfoTile extends StatelessWidget {
  const CustomerInfoTile({
    super.key,
    required this.value,
    required this.title,
    required this.icon,
  });

  final String value, title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.title20BlackBold),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white, width: 1.5),
          ),
          tileColor: AppColors.kPrimaryColor.withOpacity(0.7),
          leading: Icon(icon, color: Colors.white),
          title: Text(value, style: AppTextStyles.title16WhiteBold),
        ),
      ],
    );
  }
}
