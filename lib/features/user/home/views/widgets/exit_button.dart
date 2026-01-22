import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: SizeConfig.height * 0.05,
      right: SizeConfig.width * 0.05,
      child: GestureDetector(
        onTap: () => context.popScreen(),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.6),
            border: Border.all(color: Colors.white, width: 1),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.008,
            vertical: SizeConfig.height * 0.005,
          ),
          child: Icon(Icons.close, color: Colors.white, size: SizeConfig.width * 0.06),
        ),
      ),
    );
  }
}
