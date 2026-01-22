import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/hom/views/widgets/title_with_view_all.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTrendingShopsShimmer extends StatelessWidget {
  const LoadingTrendingShopsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithViewAll(title: LocaleKeys.trending_shops.tr()),
        SizedBox(height: SizeConfig.height * 0.015),
        SizedBox(
          height: SizeConfig.height * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: SizeConfig.width * 0.03),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: SizeConfig.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: SizeConfig.height * 0.015),
      ],
    );
  }
}
