import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/components/custom_text_form_field.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({
    super.key,
    required this.onPressed,
    required this.controller,
  });

  final Function()? onPressed;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: context.screenWidth * 0.02,
                vertical: context.screenHeight * 0.01),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(24),
            ),
            child: CustomTextFormField(
              fillColor: Colors.black12,
              controller: controller,
              hintText: LocaleKeys.enter_your_message.tr(),
              suffixIcon: SizedBox(
                height: context.screenHeight * 0.04,
                width: context.screenWidth * 0.1,
                child: CustomIconButton(
                  icon: Icons.send,
                  iconColor: AppColors.kPrimaryColor,
                  onPressed: onPressed,
                ),
              ),
            ),
          ),
        ),
        CustomIconButton(
            icon: Icons.mic_none_rounded,
            iconColor: AppColors.kPrimaryColor,
            onPressed: () {
              showToast("Comming soon");
            })
      ],
    );
  }
}
