import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/offers/models/offer_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OfferDetails extends StatelessWidget {
  const OfferDetails({super.key, required this.offer});

  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: SizeConfig.height * 0.02,
      left: SizeConfig.width * 0.04,
      right: SizeConfig.width * 0.04,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.title,
            style: AppTextStyles.title18WhiteBold.copyWith(
              fontSize: SizeConfig.width * 0.05,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          Text(
            offer.description ?? "No description available",
            style: AppTextStyles.title14White70.copyWith(
              fontSize: SizeConfig.width * 0.035,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          Text(
            "Valid until: ${DateFormat.yMMMd().format(offer.endDate)}",
            style: AppTextStyles.title14White70.copyWith(
              fontSize: SizeConfig.width * 0.035,
            ),
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status: Active",
                style: AppTextStyles.title12White70.copyWith(
                  fontSize: SizeConfig.width * 0.03,
                ),
              ),
              if (offer.offerType == 'discount' &&
                  offer.discountPercent != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.03,
                    vertical: SizeConfig.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius:
                        BorderRadius.circular(SizeConfig.width * 0.02),
                  ),
                  child: Text(
                    "Discount: ${offer.discountPercent}%",
                    style: AppTextStyles.title12PrimaryColorW500.copyWith(
                      fontSize: SizeConfig.width * 0.03,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
