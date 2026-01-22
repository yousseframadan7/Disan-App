import 'package:disan/core/helper/get_responsive_font_size.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/add_offers/models/discount_type_model.dart';
import 'package:flutter/material.dart';

class OfferTypeCard extends StatelessWidget {
  final DiscountTypeModel model;
  final bool isSelected;
  final VoidCallback onTap;

  const OfferTypeCard({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double spacing = SizeConfig.height * 0.01;
    return Card(
      elevation: isSelected ? 3 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(
                color: AppColors.kPrimaryColor,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.03,
            vertical: spacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.width * 0.03),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.kPrimaryColor.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  model.icon,
                  size: SizeConfig.width * 0.1,
                  color: isSelected ? AppColors.kPrimaryColor : Colors.grey,
                ),
              ),
              SizedBox(height: spacing),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: getResponsiveFontSize(fontSize: 16),
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.kPrimaryColor : Colors.black,
                ),
              ),
              SizedBox(height: spacing),
              Text(
                model.description,
                style: TextStyle(
                  fontSize: getResponsiveFontSize(fontSize: 13),
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
