import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.title,
    this.style,
    this.alignment,
    this.backgroundColor,
  });

  final Function()? onPressed;
  final String title;
  final TextStyle? style;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topCenter,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: backgroundColor ?? Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth * 0.00,
            vertical: 0,
          ),
          child: Text(
            title,
            style: style ?? AppTextStyles.title16PrimaryColorW500,
          ),
        ),
      ),
    );
  }
}
