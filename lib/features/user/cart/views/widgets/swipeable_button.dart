import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';

class SwipeableButton extends StatefulWidget {
  final VoidCallback onSwipeComplete;

  const SwipeableButton({super.key, required this.onSwipeComplete});

  @override
  State<SwipeableButton> createState() => _SwipeableButtonState();
}

class _SwipeableButtonState extends State<SwipeableButton> {
  double _dragPosition = 0.0;
  final double _maxDrag = SizeConfig.width * 0.8;
  bool _isSwiping = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height * 0.065,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: SizeConfig.height * 0.065,
            width: _dragPosition + SizeConfig.width * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
         Center(
            child: Text(
              LocaleKeys.checkout.tr(),
              style: AppTextStyles.title18BlackW600.copyWith(
                color: _isSwiping ? AppColors.kPrimaryColor : Colors.white,
              ),
            ),
          ),
          Positioned(
            left: _dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _isSwiping = true;
                  _dragPosition += details.delta.dx;
                  _dragPosition = _dragPosition.clamp(0.0, _maxDrag);
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition >= _maxDrag) {
                  widget.onSwipeComplete();
                }
                setState(() {
                  _isSwiping = false;
                  _dragPosition = 0.0;
                });
              },
              child: Container(
                width: SizeConfig.width * 0.15,
                height: SizeConfig.height * 0.065,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: AppColors.kPrimaryColor,
                  size: SizeConfig.width * 0.07,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}