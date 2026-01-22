import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/offers/models/offer_model.dart';
import 'package:disan/features/admin/offers/views/widgets/delete_button.dart';
import 'package:disan/features/admin/offers/views/widgets/offer_gradiant.dart';
import 'package:disan/features/admin/offers/views/widgets/offer_badge.dart';
import 'package:disan/features/admin/offers/views/widgets/offer_details.dart';
import 'package:disan/features/admin/offers/views/widgets/offer_image.dart';
import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer});

  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.width * 0.04),
          side: BorderSide(
            color: AppColors.kPrimaryColor,
            width: SizeConfig.width * 0.005,
          )),
      child: SizedBox(
        height: SizeConfig.height * 0.28,
        child: Stack(
          children: [
            OfferImage(imageUrl: offer.imageUrl),
            const OfferGradient(),
            OfferBadge(offer: offer),
            const DeleteButton(),
            OfferDetails(offer: offer),
          ],
        ),
      ),
    );
  }
}




