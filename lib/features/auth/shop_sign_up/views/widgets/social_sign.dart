import 'package:disan/core/components/custom_out_line_button_with_image.dart';
import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SocialSign extends StatelessWidget {
  const SocialSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomOutLineButtonWithImage(
          name:LocaleKeys.continue_with_google.tr(),
          image: AppImages.googleImage,
          onPressed: () {},
        ),
      ],
    );
  }
}
