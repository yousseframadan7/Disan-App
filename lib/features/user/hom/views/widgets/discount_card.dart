import 'package:disan/core/components/custom_icon_button_with_background.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/offers/models/offer_model.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    super.key,
    required this.offerModel,

  });
  final OfferModel offerModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.width * 0.03),
      child: Container(
        width: SizeConfig.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(offerModel.imageUrl!),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor.withOpacity(0.3),
                Colors.black45
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('50-40% ${LocaleKeys.off.tr()}',
                  style: AppTextStyles.title22WhiteColorBold),
              SizedBox(height: SizeConfig.height * 0.005),
               Text(LocaleKeys.now_on_all_products.tr(),
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: SizeConfig.height * 0.005),
              CustomTextButtonWithIconWithBackground(
                title: LocaleKeys.shop_now.tr(),
                onPressed: () {
                  showToast("Coming soon");
                },
                icon: Icons.shopping_bag,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
