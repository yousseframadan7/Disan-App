import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/shop_products/models/shop_model.dart';
import 'package:flutter/material.dart';

class TrendingShopCard extends StatelessWidget {
  const TrendingShopCard({
    super.key,
    required this.shop,
  });

  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushScreen(
          RouteNames.shopProductsScreen,
          arguments: shop.id,
        );
      },
      child: Container(
        width: SizeConfig.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(shop.image),
              fit: BoxFit.cover,
            )),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        shop.name,
                        style: AppTextStyles.title16WhiteBold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      shop.category!,
                      style: AppTextStyles.title14White,
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height * 0.005),
                Row(
                  children: [
                    Icon(Icons.star,
                        color: Colors.amber, size: SizeConfig.width * 0.04),
                    SizedBox(width: SizeConfig.width * 0.01),
                    Text(
                      shop.rating ?? '4.5',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
