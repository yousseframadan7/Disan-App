import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  const CustomDropDownButtonFormField({
    super.key,
    required this.userRoles,
    this.controller,
    this.hintText,
    this.title,
    this.onChanged,
    this.fillColor,
  });

  final List<String> userRoles;
  final TextEditingController? controller;
  final String? hintText;
  final String? title;
  final Function(String?)? onChanged;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) Text(title!, style: AppTextStyles.title18BlackBold),
        SizedBox(height: context.screenHeight * 0.003),
        DropdownButtonFormField<String>(
          items: userRoles
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: AppTextStyles.title18Black54),
                ),
              )
              .toList(),
          onChanged:onChanged ?? (value) {
            if (controller != null) {
              controller!.text = value.toString();
            }
          },
          isExpanded: true,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
          dropdownColor: Colors.white,
          style: AppTextStyles.title18Black54,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.015,
            ),
            filled: fillColor != null ? true : false,
            fillColor: fillColor,
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            hintText: hintText ?? "Select Your Role",
            hintStyle: AppTextStyles.title18Black54,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black38),
    );
  }
}
