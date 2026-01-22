import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/my_products/view_models/cubit/get_my_products_cubit.dart';
import 'package:disan/features/admin/my_products/views/widgets/products_local_hero_views.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProductsScreenBody extends StatelessWidget {
  const MyProductsScreenBody({
    super.key,
    required TabController? tabController,
  }) : _tabController = tabController;

  final TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => GetMyProductsCubit(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.06,
              ),
              child: Row(
                children: [
                  Text(LocaleKeys.my_products.tr(),
                      style: AppTextStyles.title24PrimaryColorBold),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      final newIndex = _tabController!.index == 0 ? 1 : 0;
                      _tabController.animateTo(newIndex);
                    },
                    icon: Icon(Icons.space_dashboard_outlined,
                        color: AppColors.kPrimaryColor),
                  ),
                ],
              ),
            ),
            ProductsLocalHeroViews(tabController: _tabController),
          ],
        ),
      ),
    );
  }
}
