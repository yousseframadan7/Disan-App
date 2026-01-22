import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: SizeConfig.height * 0.06,
      left: SizeConfig.width * 0.05,
      child: IconButton(
        icon: Icon(Icons.arrow_back,
            color: Colors.white, size: SizeConfig.width * 0.08),
        onPressed: () => context.popScreen(),
      ),
    );
  }
}
