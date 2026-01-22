import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class BadgeContainer extends StatelessWidget {
  const BadgeContainer({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.03,
        vertical: SizeConfig.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SizeConfig.width * 0.02),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: SizeConfig.width * 0.01,
            offset: Offset(0, SizeConfig.width * 0.005),
          ),
        ],
      ),
      child: Text(
        text,
        style: AppTextStyles.title12White70.copyWith(
          fontSize: SizeConfig.width * 0.035,
        ),
      ),
    );
  }
}
