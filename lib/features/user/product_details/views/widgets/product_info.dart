import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/product_details/views/widgets/translate_text.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TranslateText(
                text: product.name,
                style: AppTextStyles.title24BlackBold,
              ),
            ),
            Icon(Icons.star_rate_rounded, color: Colors.yellow.shade600),
            Text(
              "(4.5)",
              style: AppTextStyles.title16BlackW500
            ),
          ],
        ),
        SizedBox(height: SizeConfig.height * 0.005),
        TranslateText(
          text: product.description,
          style: AppTextStyles.title14Grey,
        )
      ],
    );
  }
}
