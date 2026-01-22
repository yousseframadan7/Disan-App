import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/offers/models/offer_model.dart';
import 'package:disan/features/admin/offers/views/widgets/offer_card.dart';
import 'package:flutter/material.dart';

class OffersListView extends StatelessWidget {
  const OffersListView({super.key, required this.offers});

  final List<OfferModel> offers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.04,
        vertical: SizeConfig.height * 0.02,
      ),
      itemCount: offers.length,
      separatorBuilder: (_, __) => SizedBox(height: SizeConfig.height * 0.02),
      itemBuilder: (context, index) {
        return OfferCard(offer: offers[index]);
      },
    );
  }
}

