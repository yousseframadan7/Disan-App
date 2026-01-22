import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/features/admin/add_offers/models/discount_type_model.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static final List<String> banners = [
    AppImages.categoryImage1,
    AppImages.categoryImage2,
    AppImages.categoryImage1,
    AppImages.categoryImage2,
  ];

  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'cat1',
      name: 'Beauty',
      image: 'https://images.pexels.com/photos/301703/pexels-photo-301703.jpeg',
      description: 'Premium skincare and makeup products.',
    ),
    CategoryModel(
      id: 'cat2',
      name: 'Fashion',
      image:
          'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg',
      description: 'Trendy clothing and accessories.',
    ),
    CategoryModel(
      id: 'cat3',
      name: 'Kids',
      image: 'https://images.pexels.com/photos/36029/pexels-photo.jpg',
      description: 'Fun products for children.',
    ),
  ];

  static List<DiscountTypeModel> discountTypes = [
    DiscountTypeModel(
      keyValue: "discount",
      title: LocaleKeys.discount.tr(),
      description: LocaleKeys.discount.tr(),
      icon: Icons.discount,
    ),
    DiscountTypeModel(
      keyValue: "buyXgetYSame",
      title: LocaleKeys.buy_x_get_y_same_description.tr(),
      description: LocaleKeys.buy_x_get_y_same_description.tr(),
      icon: Icons.repeat_one,
    ),
    DiscountTypeModel(
      keyValue: "buyXgetYDifferent",
      title: LocaleKeys.buy_x_get_y_another.tr(),
      description: LocaleKeys.buy_x_get_y_another_description.tr(),
      icon: Icons.swap_horiz,
    ),
    DiscountTypeModel(
      keyValue: "gift",
      title: LocaleKeys.gift.tr(),
      description: LocaleKeys.gift_description.tr(),
      icon: Icons.card_giftcard,
    ),
  ];
}
