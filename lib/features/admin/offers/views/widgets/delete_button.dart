import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: SizeConfig.height * 0.02,
      right: SizeConfig.width * 0.04,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: SizeConfig.width * 0.01,
              offset: Offset(0, SizeConfig.width * 0.005),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: AppColors.kPrimaryColor,
            size: SizeConfig.width * 0.07,
          ),
          onPressed: () {
            showToast("Coming soon");
          },
        ),
      ),
    );
  }
}

