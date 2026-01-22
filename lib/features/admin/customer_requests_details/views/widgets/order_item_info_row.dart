import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderItemInfoRow extends StatelessWidget {
  const OrderItemInfoRow({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
 });

  final String title;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,
            color: Colors.white70,
            size: SizeConfig.width * 0.05),
        SizedBox(
            width: SizeConfig.width * 0.01),
        Text(
          '$title: $value',
          style: AppTextStyles.title14White
              .copyWith(
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
