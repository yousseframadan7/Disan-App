import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShopInfo extends StatelessWidget {
  const ShopInfo({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
      child: Text(
        description,
        style: AppTextStyles.title14Grey,
      ),
    );
  }
}
