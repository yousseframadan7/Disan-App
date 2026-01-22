import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/offers/models/offer_model.dart';
import 'package:disan/features/admin/offers/views/widgets/badge_container.dart';
import 'package:flutter/material.dart';

class OfferBadge extends StatelessWidget {
  const OfferBadge({super.key, required this.offer});

  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    if (offer.offerType == 'discount' && offer.discountPercent != null) {
      return Positioned(
        top: SizeConfig.height * 0.012,
        left: -SizeConfig.width * 0.09,
        child: Transform.rotate(
          angle: -0.6,
          child: Container(
            width: SizeConfig.width * 0.4,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(SizeConfig.width * 0.02),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: SizeConfig.width * 0.01,
                  offset: Offset(0, SizeConfig.width * 0.005),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "${offer.discountPercent}% OFF",
                style: AppTextStyles.title12PrimaryColorW500.copyWith(
                  fontSize: SizeConfig.width * 0.035,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    } else if (offer.offerType == 'buyXgetYSame' &&
        offer.buyQuantity != null &&
        offer.getQuantity != null) {
      return Positioned(
        top: SizeConfig.height * 0.02,
        left: SizeConfig.width * 0.04,
        child: BadgeContainer(
          color: Colors.green.withOpacity(0.9),
          text: "Buy ${offer.buyQuantity} Get ${offer.getQuantity} Same",
        ),
      );
    } else if (offer.offerType == 'buyXgetYDifferent' &&
        offer.buyQuantity != null &&
        offer.getQuantity != null) {
      return Positioned(
        top: SizeConfig.height * 0.02,
        left: SizeConfig.width * 0.04,
        child: BadgeContainer(
          color: Colors.blue.withOpacity(0.9),
          text: "Buy ${offer.buyQuantity} Get ${offer.getQuantity} Different",
        ),
      );
    } else if (offer.offerType == 'gift') {
      return Positioned(
        top: SizeConfig.height * 0.02,
        left: SizeConfig.width * 0.04,
        child: Container(
          padding: EdgeInsets.all(SizeConfig.width * 0.03),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: SizeConfig.width * 0.01,
                offset: Offset(0, SizeConfig.width * 0.005),
              ),
            ],
          ),
          child: Icon(
            Icons.card_giftcard,
            color: Colors.white,
            size: SizeConfig.width * 0.06,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
