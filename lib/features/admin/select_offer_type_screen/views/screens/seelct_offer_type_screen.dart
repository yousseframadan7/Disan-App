import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/select_offer_type_screen/view_models/cubit/discount_type_cubit_cubit.dart';
import 'package:disan/features/admin/select_offer_type_screen/views/widgets/offer_type_card.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:disan/core/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectOfferTypeScreen extends StatelessWidget {
  const SelectOfferTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscountTypeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.select_discount_type.tr()),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.kPrimaryColor,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.03,
            vertical: SizeConfig.height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: BlocBuilder<DiscountTypeCubit, String?>(
                  builder: (context, selectedKey) {
                    return GridView.builder(
                      itemCount: AppConstants.discountTypes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final discount = AppConstants.discountTypes[index];
                        final isSelected = selectedKey == discount.keyValue;
                        return OfferTypeCard(
                          model: discount,
                          isSelected: isSelected,
                          onTap: () async {
                            context
                                .read<DiscountTypeCubit>()
                                .selectDiscountType(discount.keyValue);
                            await getIt<CacheHelper>().saveData(
                                key: "offerType", value: discount.keyValue);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.02),
              BlocBuilder<DiscountTypeCubit, String?>(
                builder: (context, selectedKey) {
                  return CustomElevatedButton(
                    onPressed: selectedKey == null
                        ? null
                        : () {
                            context.pushReplacementScreen(
                                RouteNames.addOfferScreen);
                          },
                    name: LocaleKeys.Continue.tr(),
                    backgroundColor: selectedKey == null
                        ? Colors.grey
                        : AppColors.kPrimaryColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
