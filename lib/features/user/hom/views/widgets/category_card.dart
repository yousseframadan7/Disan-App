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
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.pushScreen(
          RouteNames.categoryScreen,
          arguments: category.toJson(),
        );
      },
      child: Container(
        width: SizeConfig.width * .43,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * .025,
          vertical: SizeConfig.height * .012,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kPrimaryColor, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: SizeConfig.width * .14,
              height: SizeConfig.width * .14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  category.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.width * .03),
            Expanded(
              child: TranslateText(
                text: category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.title16Blue500.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.kPrimaryColor.withOpacity(.6),
            ),
          ],
        ),
      ),
    );
  }
}
