import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/components/custom_elevated_button.dart';
import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/auth/sign_in/views/widgets/gradiant_container.dart';
import 'package:flutter/material.dart';

class SelectRoleScreenBody extends StatelessWidget {
  const SelectRoleScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradiantContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.05,
          vertical: SizeConfig.height * 0.05,
        ),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.height * 0.05),
            Image.asset(AppImages.logoImage, height: SizeConfig.height * 0.3),
            Text("Select Role", style: AppTextStyles.title28WhiteColorW500),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomElevatedButton(
                    name: "Seller",
                    onPressed: () {
                      context.pushScreen(RouteNames.signInScreen);
                    }),
                SizedBox(height: SizeConfig.height * 0.02),
                CustomElevatedButton(
                    name: "Buyer",
                    onPressed: () {
                      context.pushScreen(RouteNames.signInScreen);
                    }),
                SizedBox(height: SizeConfig.height * 0.02),
              ],
            )
          ],
        ),
      ),
    );
  }
}
