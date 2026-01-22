import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class SpaceWithDivider extends StatelessWidget {
  const SpaceWithDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.01,
          ),
          child: Divider(
            color: AppColors.kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
