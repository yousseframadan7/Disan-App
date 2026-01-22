import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DiscountCardShimmer extends StatelessWidget {
  const DiscountCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.width * 0.03),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: SizeConfig.width * 0.8,
          height: SizeConfig.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
