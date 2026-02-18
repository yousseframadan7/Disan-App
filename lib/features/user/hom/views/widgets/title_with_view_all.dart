import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/custom_text_button.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TitleWithViewAll extends StatelessWidget {
  const TitleWithViewAll({super.key, required this.title, this.onPressed});
  final String title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.title20BlackW500),
        CustomTextButton(
          title: LocaleKeys.view_all.tr(),
          onPressed:
              onPressed ??
              () {
                Navigator.of(context).pushNamed(RouteNames.allProducts);
              },
        ),
      ],
    );
  }
}
