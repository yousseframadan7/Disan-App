import 'package:flutter/material.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.width * 0.01,
      height: SizeConfig.height * 0.03,
      child: VerticalDivider(
        color: Colors.white,
        thickness: 1.5,
      ),
    );
  }
}
