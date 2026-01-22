import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class CustomOfferDropDownButtonFormField extends StatelessWidget {
  final List<ProductModel> items;
  final String hintText;
  final String title;
  final Color primaryColor;
  final TextEditingController? controller;
  final Function(ProductModel?)? onChanged;
  const CustomOfferDropDownButtonFormField({
    super.key,
    this.controller,
    required this.items,
    required this.hintText,
    required this.title,
    this.onChanged,
    this.primaryColor = const Color(0xFF187BCE),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.arrow_drop_down_circle_rounded,
              size: SizeConfig.height * 0.03,
              color: primaryColor,
            ),
            SizedBox(width: SizeConfig.width * 0.02),
            Text(
              title,
              style: AppTextStyles.title18BlackW600,
            ),
          ],
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        DropdownButtonFormField<ProductModel>(
          onChanged: onChanged ??
              (value) {
                if (controller != null) {
                  controller!.text = value.toString();
                }
              },
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.title16Grey,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.02,
            ),
          ),
          items: items.map((role) {
            return DropdownMenuItem<ProductModel>(
              value: role,
              child: Text(
                role.name,
                style: TextStyle(
                  fontSize: SizeConfig.height * 0.02,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
