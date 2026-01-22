import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/user/categories/view_models/cubit/get_shops_by_category_cubit.dart';
import 'package:disan/features/user/categories/views/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class CategoryScreenBody extends StatelessWidget {
  const CategoryScreenBody({
    super.key,
    required this.categoryName,
  });
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.03,
        vertical: SizeConfig.height * 0.02,
      ),
      child: BlocBuilder<GetShopsByCategoryCubit, GetShopsByCategoryState>(
        builder: (context, state) {
          if (state is GetShopsByCategoryLoading) {
            return CustomLoading();
          }
          if (state is GetShopsByCategoryFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          if (state is EmptyShops) {
            return Center(child: Lottie.asset(AppLotties.emptyRequestsLottie));
          }
          final shops = context.read<GetShopsByCategoryCubit>().shops;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: SizeConfig.width * 0.02,
              mainAxisSpacing: SizeConfig.height * 0.02,
              childAspectRatio: 0.85,
            ),
            itemCount: shops.length,
            itemBuilder: (context, index) {
              return CategoryCard(shop: shops[index]);
            },
          );
        },
      ),
    );
  }
}
