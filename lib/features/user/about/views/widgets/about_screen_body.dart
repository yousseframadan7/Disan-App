import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/about/views/widgets/about_info_row.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutScreenBody extends StatelessWidget {
  const AboutScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.05,
          vertical: SizeConfig.height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  iconSize: SizeConfig.width * 0.06,
                  onPressed: () => context.popScreen(),
                  hPadding: SizeConfig.width * 0.03,
                  vPadding: SizeConfig.height * 0.03,
                  child:  Icon(Icons.arrow_back,color: AppColors.kPrimaryColor,),
                ),
                Text("About", style: AppTextStyles.title24PrimaryColorBold),
                SizedBox(width: SizeConfig.width * 0.08),
              ],
            ),
            SizedBox(height: SizeConfig.height * 0.02),
            Center(
              child: CircleAvatar(
                radius: SizeConfig.width * 0.2,
                backgroundImage:  AssetImage(AppImages.logoImage),
                backgroundColor: AppColors.kPrimaryColor.withOpacity(0.2),
              ),
            ),
            SizedBox(height: SizeConfig.height * 0.02),
            Text(
              "Welcome to Disan!",
              style: AppTextStyles.title24PrimaryColorBold,
            ),
            SizedBox(height: SizeConfig.height * 0.02),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Disan is a modern e-commerce application that connects shops with customers in one platform. It makes it easy for sellers to showcase their products and for users to browse, add to cart, and purchase items smoothly.\n",
                      style: AppTextStyles.title16Black.copyWith(height: 1.5),
                    ),

                    Text("For Shops 🏬",
                        style: AppTextStyles.title16Black
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      "- Create a shop account and manage your store.\n"
                      "- Add and display products with details, images, and prices.\n"
                      "- Manage customer orders efficiently.\n",
                      style: AppTextStyles.title16Black.copyWith(height: 1.5),
                    ),

                    // For Users
                    Text("For Users 🛒",
                        style: AppTextStyles.title16Black
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      "- Explore shops and a wide range of products.\n"
                      "- Add items to your shopping cart and place orders easily.\n"
                      "- Enjoy a simple and secure shopping experience.\n",
                      style: AppTextStyles.title16Black.copyWith(height: 1.5),
                    ),

                    // Key Features
                    Text("Key Features ✨",
                        style: AppTextStyles.title16Black
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(
                      "- Dual user roles: Shop & Customer.\n"
                      "- Easy product listing and cart management.\n"
                      "- Real-time order updates and notifications.\n"
                      "- Clean and user-friendly design.\n",
                      style: AppTextStyles.title16Black.copyWith(height: 1.5),
                    ),

                    SizedBox(height: SizeConfig.height * 0.02),

                    // Info Rows
                    AboutInfoRow(
                      icon: Icons.location_on,
                      text: LocaleKeys.dakahlya_center.tr(),
                    ),
                    SizedBox(height: SizeConfig.height * 0.02),
                    const AboutInfoRow(
                      icon: Icons.phone,
                      text: "+20 1123456789",
                    ),
                    SizedBox(height: SizeConfig.height * 0.02),
                    const AboutInfoRow(
                      icon: Icons.email,
                      text: 'disan.stores@gmail.com',
                    ),
                    SizedBox(height: SizeConfig.height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
