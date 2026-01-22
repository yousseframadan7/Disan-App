import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/user/hom/views/widgets/title_with_view_all.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWithViewAll(title: LocaleKeys.trending_shops.tr()),
        SizedBox(height: SizeConfig.height * 0.015),
        Center(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.red,
              fontSize: SizeConfig.height * 0.02,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.height * 0.035),
      ],
    );
  }
}
