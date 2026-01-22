import 'package:flutter/material.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/translation_services.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class TranslateText extends StatelessWidget {
  const TranslateText({
    super.key,
    required this.text,
    this.style,
  });

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final translationService = getIt<TranslationService>();

    return FutureBuilder<String>(
      future: translationService.translate(text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !(snapshot.hasData)) {
          return Text(text, style: style ?? AppTextStyles.title16Black);
        } else if (snapshot.hasError) {
          return Text(text, style: style ?? AppTextStyles.title16Black);
        } else {
          return Text(snapshot.data ?? text,
              style: style ?? AppTextStyles.title16Black);
        }
      },
    );
  }
}
