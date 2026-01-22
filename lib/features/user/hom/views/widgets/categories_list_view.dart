import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:disan/features/user/hom/views/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.07,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: SizeConfig.width * 0.02),
            child: CategoryCard(category: categories[index]),
          );
        },
      ),
    );
  }
}
