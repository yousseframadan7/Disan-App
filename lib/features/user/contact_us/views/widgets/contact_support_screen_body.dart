import 'package:disan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/contact_us/views/widgets/comon_question.dart';
import 'package:disan/features/user/contact_us/views/widgets/conatct_us_card.dart';
import 'package:disan/features/user/contact_us/views/widgets/location_on_map.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class ContactSupportScreenBody extends StatelessWidget {
  const ContactSupportScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.02,
          vertical: SizeConfig.height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Lottie.asset(
                  AppLotties.supportLottie,
                  height: SizeConfig.height * 0.25,
                ),
                SizedBox(height: SizeConfig.height * 0.005),
                Text(LocaleKeys.how_can_we_help.tr(),
                    style: AppTextStyles.title22PrimaryColorBold),
                SizedBox(height: SizeConfig.height * 0.005),
                Text(
                  LocaleKeys.technical_support_availability.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title16Grey,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.height * 0.02),
            ContactUsCard(
              icon: Icons.email,
              title: LocaleKeys.email.tr(),
              iconColor: Colors.red,
              url: Uri.parse('mailto:7a4eI@example.com'),
              subTitle: "disan.stores@gmail.com",
            ),
            SizedBox(height: SizeConfig.height * 0.005),
            ContactUsCard(
              icon: FontAwesomeIcons.facebook,
              title: LocaleKeys.facebook.tr(),
              iconColor: Colors.blue[800]!,
              subTitle: "Disan Store",
              url: Uri.parse(
                  'https://www.facebook.com/share/1ZQiKhfhqp/?mibextid=wwXIfr'),
            ),
            SizedBox(height: SizeConfig.height * 0.005),
            ContactUsCard(
              icon: FontAwesomeIcons.instagram,
              title: LocaleKeys.instagram.tr(),
              iconColor: const Color.fromARGB(255, 228, 62, 172),
              subTitle: "Disan Store",
              url: Uri.parse(
                  'https://www.instagram.com/hekaya_stour?igsh=MWRjMDdkb3ZpMmUzag=='),
            ),
            SizedBox(height: SizeConfig.height * 0.005),
            ContactUsCard(
              icon: FontAwesomeIcons.whatsapp,
              title: LocaleKeys.whats_app.tr(),
              subTitle: "+201225084331",
              iconColor: Colors.green,
              url: Uri.parse('https://wa.me/+201225084331'),
            ),
            SizedBox(height: SizeConfig.height * 0.005),
            LocationOnMap(),
            SizedBox(height: SizeConfig.height * 0.02),
            CommonQuestions(),
            SizedBox(height: SizeConfig.height * 0.01),
          ],
        ),
      ),
    );
  }
}
