import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/widgets.dart';

class OrderInfoRow extends StatelessWidget {
  const OrderInfoRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.title18Black,
        ),
        Text(
          value,
          style: AppTextStyles.title18Black,
        ),
      ],
    );
  }
}
