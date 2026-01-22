import 'package:disan/core/components/custom_app_bar.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:disan/features/user/categories/view_models/cubit/get_shops_by_category_cubit.dart';
import 'package:disan/features/user/categories/views/widgets/categories_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var category = CategoryModel.fromJson(args);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        shopName: category.name,
      ),
      body: BlocProvider(
        create: (context) => GetShopsByCategoryCubit(categoryId: category.id),
        child: CategoryScreenBody(categoryName: category.name),
      ),
    );
  }
}
