import 'package:flutter/material.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/product_details/views/widgets/quantity_selector.dart';

class ProductImageAndQuantity extends StatelessWidget {
  const ProductImageAndQuantity({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.45,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Container(
                height: SizeConfig.height * 0.4,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: SizeConfig.width * 0.1,
                  ),
                ),
              ),
            ),
          ),
          getIt<CacheHelper>().getUserModel()!.role != 'shop'
              ? QuantitySelector()
              : SizedBox(),
        ],
      ),
    );
  }
}
