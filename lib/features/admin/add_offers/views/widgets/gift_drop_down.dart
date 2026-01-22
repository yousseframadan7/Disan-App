import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/features/admin/add_offers/view_models/cubit/add_offer_cubit.dart';
import 'package:disan/features/admin/add_offers/views/widgets/custom_drop_down_button_form_filed.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GiftDropdown extends StatelessWidget {
  final AddOfferCubit cubit;
  const GiftDropdown({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return CustomOfferDropDownButtonFormField(
      items: cubit.products,
      hintText: LocaleKeys.select_gift_product.tr(),
      title: LocaleKeys.gift_product.tr(),
      primaryColor: AppColors.kPrimaryColor,
      onChanged: (value) {
        cubit.selectedProductForOffer =
            cubit.products.firstWhere((p) => p.id == value!.id);
      },
    );
  }
}
