import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.02,
          vertical: SizeConfig.height * 0.008,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المنتج الوهمية
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // مكان الزر المفضل
                    Positioned(
                      top: SizeConfig.height * 0.015,
                      right: SizeConfig.width * 0.015,
                      child: Container(
                        width: SizeConfig.width * 0.1,
                        height: SizeConfig.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // مكان السعر
                    Positioned(
                      bottom: SizeConfig.height * 0.005,
                      right: SizeConfig.width * 0.005,
                      child: Container(
                        width: SizeConfig.width * 0.15,
                        height: SizeConfig.height * 0.025,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.02,
                  vertical: SizeConfig.height * 0.01,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig.height * 0.02,
                      width: SizeConfig.width * 0.4,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: SizeConfig.height * 0.008),
                    Container(
                      height: SizeConfig.height * 0.015,
                      width: SizeConfig.width * 0.6,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: SizeConfig.height * 0.008),
                    Row(
                      children: [
                        Container(
                          width: SizeConfig.width * 0.05,
                          height: SizeConfig.width * 0.05,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(width: SizeConfig.width * 0.01),
                        Container(
                          width: SizeConfig.width * 0.08,
                          height: SizeConfig.height * 0.015,
                          color: Colors.grey.shade300,
                        ),
                        const Spacer(),
                        Container(
                          width: SizeConfig.width * 0.08,
                          height: SizeConfig.height * 0.015,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
