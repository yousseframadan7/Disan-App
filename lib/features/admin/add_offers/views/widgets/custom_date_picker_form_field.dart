import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomDatePickerFormField extends StatelessWidget {
  final String hintText;
  final String title;
  final TextEditingController? controller;
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color primaryColor;

  const CustomDatePickerFormField({
    super.key,
    required this.hintText,
    required this.title,
    this.controller,
    this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.primaryColor = const Color(0xFF187BCE),
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(Icons.calendar_today_rounded,
            size: SizeConfig.height * 0.03, color: primaryColor),
        SizedBox(width: SizeConfig.width * 0.02),
        Text(title, style: AppTextStyles.title18BlackW600),
      ]),
      SizedBox(height: SizeConfig.height * 0.01),
      TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now().add(const Duration(days: 30)),
            firstDate: firstDate ?? DateTime.now(),
            lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
            locale: const Locale('ar', 'SA'),
          );
          if (picked != null) {
            final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
            controller?.text = formattedDate;
            onDateSelected?.call(picked);
          }
        },
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
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.02,
          ),
        ),
        style: TextStyle(
          fontSize: SizeConfig.height * 0.02,
          color: Colors.black87,
        ),
      ),
    ]);
  }
}
