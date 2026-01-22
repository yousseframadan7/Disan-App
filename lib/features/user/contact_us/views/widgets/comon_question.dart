import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/contact_us/views/widgets/fq_cqrd.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CommonQuestions extends StatelessWidget {
  const CommonQuestions({super.key});

  static final List<Map<String, String>> _faqItems = [
    {
      'question': LocaleKeys.faq_track_order_answer.tr(),
      'answer': LocaleKeys.faq_track_order_answer.tr(),
    },
    {
      'question': LocaleKeys.faq_payment_methods_question.tr(),
      'answer': LocaleKeys.faq_payment_methods_answer.tr(),
    },
    {
      'question': LocaleKeys.faq_return_product_answer.tr(),
      'answer': LocaleKeys.faq_return_product_answer.tr()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width * 0.02,
          ),
          child: Text(LocaleKeys.faq.tr(),
              style: AppTextStyles.title18PrimaryColorW700),
        ),
        SizedBox(height: SizeConfig.height * 0.005),
        ..._faqItems.map((item) => FAQCard(
              question: item['question']!,
              answer: item['answer']!,
            )),
      ],
    );
  }
}
