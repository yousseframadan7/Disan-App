
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({
    super.key,
    required this.shopName,
    required this.shopCategory,
    required this.shopImage,
  });
  final String shopName, shopCategory,shopImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.03,
        vertical: SizeConfig.height * 0.02,
      ),
      child: Row(
        children: [
          Container(
            width: SizeConfig.width * 0.2,
            height: SizeConfig.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(SizeConfig.width * 0.03),
              image: DecorationImage(
                image: NetworkImage(shopImage),
                fit: BoxFit.cover,
              )
            ),
          ),
          SizedBox(width: SizeConfig.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(shopName, style: AppTextStyles.title20BlackBold),
                Text(shopCategory, style: AppTextStyles.title14Grey),
                SizedBox(height: SizeConfig.height * 0.01),
                Row(
                  children: List.generate(
                    4,
                    (_) => Icon(Icons.star,
                        color: Colors.amber, size: SizeConfig.width * 0.04),
                  )
                    ..add(Icon(Icons.star_half,
                        color: Colors.amber, size: SizeConfig.width * 0.04))
                    ..add(SizedBox(width: SizeConfig.width * 0.01))
                    ..add(Text('4.5',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
