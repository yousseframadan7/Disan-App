import 'dart:io';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PickImage extends StatefulWidget {
  const PickImage({
    super.key,
    required this.imageFile,
    required this.onPickImage,
  });

  final File? imageFile;
  final VoidCallback onPickImage;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.imageFile == null ? _animation.value : 1.0,
          child: GestureDetector(
            onTap: widget.onPickImage,
            child: Container(
              height: SizeConfig.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kPrimaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.imageFile == null
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                LocaleKeys.pick_an_image
                                    .tr(), //  "Pick an image",
                                style: AppTextStyles.title16PrimaryColorW500),
                            SizedBox(width: SizeConfig.width * 0.02),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.kPrimaryColor,
                            )
                          ],
                        ),
                      )
                    : Image.file(
                        widget.imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
