import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/hom/view_models/cubit/get_categories_cubit.dart';
import 'package:disan/features/user/hom/views/widgets/categories_list_view.dart';
import 'package:disan/features/user/hom/views/widgets/category_shimmer.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCategoriesCubit(),
      child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
        builder: (context, state) {
          if (state is GetCategoriesLoading) {
            return const CategoryShimmer();
          }
          if (state is GetCategoriesFailure) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.title16Black,
              ),
            );
          }
          if (state is EmptyCategories) {
            return Center(
              child: Text(
             LocaleKeys.no_categories_available.tr(),
              ),
            );
          }
          var categories = context.read<GetCategoriesCubit>().categories;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.categories.tr(),
                style: AppTextStyles.title20BlackW500,
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              CategoriesListView(categories: categories),
            ],
          );
        },
      ),
    );
  }
}


