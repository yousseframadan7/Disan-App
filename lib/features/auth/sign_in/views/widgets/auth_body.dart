import 'dart:ui';

import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.height * 0.05,
        left: SizeConfig.width * 0.05,
        right: SizeConfig.width * 0.05,
      ),
      height: SizeConfig.height * 0.7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.height * 0.06),
          topRight: Radius.circular(SizeConfig.height * 0.06),
        ),
      ),
      child: child,
    );
  }
}