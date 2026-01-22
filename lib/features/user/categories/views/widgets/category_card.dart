import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/shop_products/models/shop_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.shop,
  });

  final ShopModel shop;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushScreen(RouteNames.shopProductsScreen, arguments: shop.id);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(shop.image),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: SizeConfig.height * 0.05,
                left: SizeConfig.width * 0.05,
                right: SizeConfig.width * 0.05,
                child: Text(shop.name, style: AppTextStyles.title16WhiteW600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
