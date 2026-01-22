import 'package:disan/features/admin/add_offers/view_models/cubit/add_offer_cubit.dart';
import 'package:disan/features/admin/add_offers/views/widgets/custom_offer_text_field.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DiscountField extends StatelessWidget {
  final AddOfferCubit cubit;
  const DiscountField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return CustomOfferTextField(
      label: LocaleKeys.discount_percentage.tr(),
      hint: LocaleKeys.enter_discount_percentage.tr(),
      controller: cubit.discountController,
      maxLines: 1,
      keyboardType: TextInputType.number,
      prefixText: "% ",
      isRequired: true,
      icon: Icons.percent_rounded,
    );
  }
}
