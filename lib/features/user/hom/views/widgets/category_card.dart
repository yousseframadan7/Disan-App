import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/translate_text.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushScreen(RouteNames.categoryScreen,
            arguments: category.toJson());
      },
      child: SizedBox(
        width: SizeConfig.width * 0.45,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.015,
            vertical: SizeConfig.height * 0.01,
          ),
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: SizeConfig.width * 0.065,
                backgroundImage: NetworkImage(category.image),
              ),
              SizedBox(height: SizeConfig.height * 0.007),
              Expanded(
                child: TranslateText(
                  text: category.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.title16White500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
