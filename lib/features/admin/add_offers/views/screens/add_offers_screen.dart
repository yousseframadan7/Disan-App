import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/components/custom_app_bar.dart';
import 'package:disan/features/admin/add_offers/views/widgets/add_offer_screen_body.dart';
import 'package:disan/generated/locale_keys.g.dart';

class AddOfferScreen extends StatelessWidget {
  const AddOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(shopName: LocaleKeys.add_offer.tr()),
      body: AddOfferScreenBody(),
    );
  }
}


