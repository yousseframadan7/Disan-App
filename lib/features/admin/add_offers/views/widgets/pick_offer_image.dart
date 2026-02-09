import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';

class PickOfferImage extends StatelessWidget {
  const PickOfferImage({
    super.key,
    this.image,
    this.onTap,
  });
  final File? image;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: SizeConfig.height * 0.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kPrimaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: image != null
            ? Image.file(image!, fit: BoxFit.cover)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: SizeConfig.height * 0.04,
                    color: AppColors.kPrimaryColor,
                  ),
                  SizedBox(height: SizeConfig.height * 0.02),
                  Text(
                    LocaleKeys.upload_offer_image.tr(),
                    style: AppTextStyles.title18BlackW600,
                  ),
                ],
              ),
      ),
    );
  }
}
