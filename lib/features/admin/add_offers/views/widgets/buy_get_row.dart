import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/add_offers/view_models/cubit/add_offer_cubit.dart';
import 'package:disan/features/admin/add_offers/views/widgets/custom_offer_text_field.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuyGetRow extends StatelessWidget {
  final AddOfferCubit cubit;
  const BuyGetRow({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomOfferTextField(
            label: LocaleKeys.buy_quantity.tr(),
            hint: LocaleKeys.enter_buy_quantity.tr(),
            maxLines: 1,
            keyboardType: TextInputType.number,
            isRequired: true,
            icon: Icons.shopping_cart_rounded,
            controller: cubit.buyController,
          ),
        ),
        SizedBox(width: SizeConfig.width * 0.03),
        Expanded(
          child: CustomOfferTextField(
            label: LocaleKeys.get_quantity.tr(),
            hint: LocaleKeys.enter_get_quantity.tr(),
            maxLines: 1,
            keyboardType: TextInputType.number,
            isRequired: true,
            icon: Icons.shopping_bag_rounded,
            controller: cubit.getController,
          ),
        ),
      ],
    );
  }
}
