import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/translate_text.dart';
import 'package:disan/core/helper/translation_services.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_requests_details/models/order_item_model.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/item_category.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/order_item_info_row.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.item,
  });

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    final translationService = TranslationService();
    return GestureDetector(
      onTap: () {
        context.pushScreen(
          RouteNames.productDetailsScreen,
          arguments: item.product!.toJson(),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.kPrimaryColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(SizeConfig.width * 0.04),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor,
                Color(0xFFB0E0E6).withOpacity(0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  item.product!.image,
                  width: SizeConfig.width * 0.3,
                  height: SizeConfig.height * 0.15,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.image_not_supported,
                      size: SizeConfig.width * 0.15),
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslateText(
                      text: item.product!.name,
                      style: AppTextStyles.title16WhiteW600,
                    ),
                    SizedBox(height: SizeConfig.height * 0.01),
                    OrderItemInfoRow(
                      title: LocaleKeys.quantity.tr(),
                      value: item.quantity.toString(),
                      icon: Icons.shopping_bag,
                    ),
                    SizedBox(height: SizeConfig.height * 0.01),
                    OrderItemInfoRow(
                      title: LocaleKeys.price.tr(),
                      value: item.product!.price.toString(),
                      icon: Icons.attach_money,
                    ),
                    SizedBox(height: SizeConfig.height * 0.01),
                    OrderItemInfoRow(
                      title: "From",
                      value: item.product!.shopName.toString(),
                      icon: Icons.shopping_bag,
                    ),
                    SizedBox(height: SizeConfig.height * 0.01),
                    ItemCategory(category: item.product!.category),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      '${LocaleKeys.total.tr()} ${item.product!.price * item.quantity}',
                      style: AppTextStyles.title16WhiteW600),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
