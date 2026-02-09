import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.fillColor,
    this.onChanged,
    this.onTap,
    this.enabled = true,
  });

  final int maxLines;
  final String? hintText;
  final String? label;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.title14Grey,
          ),
          SizedBox(height: SizeConfig.height * 0.008),
        ],
        TextFormField(
          enabled: enabled,
          maxLines: maxLines,
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          style: AppTextStyles.title18Black,
          decoration: InputDecoration(
            filled: fillColor != null,
            fillColor: fillColor,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: AppTextStyles.title16Black54,
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.015,
            ),
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    );
  }
}
