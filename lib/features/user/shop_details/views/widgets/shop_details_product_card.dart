import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';

class ShopDetailsProductCard extends StatelessWidget {
  const ShopDetailsProductCard({
    super.key, required this.product,
  }); 
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushScreen(RouteNames.productDetailsScreen,
          arguments: product.toJson()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeConfig.width * 0.02),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(SizeConfig.width * 0.02)),
                  child: Image.network(
                   product. image,
                    height: SizeConfig.height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: SizeConfig.height * 0.01,
                  right: SizeConfig.width * 0.02,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: SizeConfig.width * 0.035,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: SizeConfig.width * 0.05,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.width * 0.025),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: SizeConfig.height * 0.005),
                  Text(
                   product. description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizeConfig.height * 0.01),
                  Text("${product.price.toStringAsFixed(2)} LE",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: SizeConfig.height * 0.01),
                  Row(
                    children: List.generate(
                      4,
                      (_) =>
                          const Icon(Icons.star, color: Colors.amber, size: 12),
                    )..add(const Icon(Icons.star_half,
                        color: Colors.amber, size: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
