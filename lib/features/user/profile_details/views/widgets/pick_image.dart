import 'dart:io';

import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class PickImage extends StatelessWidget {
  const PickImage({
    super.key,
    required this.networkImage,
    this.fileImage,
    this.onTap,
  });

  final String networkImage;
  final File? fileImage;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          
          padding: EdgeInsets.all(SizeConfig.width * 0.015),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.kPrimaryColor,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            backgroundImage: fileImage != null
                ? FileImage(fileImage!)
                : NetworkImage(networkImage),
            radius: SizeConfig.width * 0.2,
            backgroundColor: Colors.grey[200],
          ),
        ),
        Positioned(
            bottom: SizeConfig.height * 0.02,
            right: SizeConfig.width * 0.03,
            child: CustomIconButton(
              icon: Icons.camera_alt,
              onPressed: onTap,
              backgroundColor: AppColors.kPrimaryColor,
            )),
      ],
    );
  }
}
