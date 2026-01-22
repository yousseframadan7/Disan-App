import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';

class ShopProductCard extends StatelessWidget {
  const ShopProductCard({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.pushScreen(RouteNames.productDetailsScreen, arguments: product.toJson()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  color: Colors.grey.shade100,
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.network(
                      product.image,
                    )),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.02,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.title14BlackW600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: SizeConfig.height * 0.005),
                    Text(
                      product.price.toString(),
                      style: AppTextStyles.title14BlackBold,
                    ),
                    SizedBox(height: SizeConfig.height * 0.005),
                    Text("${(product.price / .9).toStringAsFixed(2)} LE",
                        style: AppTextStyles.title12Grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
