import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class FAQCard extends StatefulWidget {
  final String question;
  final String answer;

  const FAQCard({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<FAQCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _elevationAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.height * 0.01),
      child: MouseRegion(
        onEnter: (_) => _controller.forward(),
        onExit: (_) => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _elevationAnimation.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      AppColors.kPrimaryColor.withOpacity(0.05),
                    ],
                  ),
                ),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(
                    widget.question,
                    style: AppTextStyles.title16BlackBold.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  iconColor: AppColors.kPrimaryColor,
                  collapsedIconColor: AppColors.kPrimaryColor,
                  tilePadding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.04,
                  ),
                  childrenPadding:
                      EdgeInsets.only(bottom: SizeConfig.height * 0.01),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  controlAffinity: ListTileControlAffinity.trailing,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(SizeConfig.width * 0.04, 0,
                          SizeConfig.width * 0.04, SizeConfig.height * 0.01),
                      child: AnimatedOpacity(
                        opacity: _controller.value > 0.5 ? 1.0 : 0.7,
                        duration: const Duration(milliseconds: 300),
                        child: Text(widget.answer,
                            style: AppTextStyles.title16Black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
