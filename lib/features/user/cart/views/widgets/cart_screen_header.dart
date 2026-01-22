import 'package:flutter/material.dart';
import 'package:disan/core/components/custom_icon_button.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class CartScreenHeader extends StatelessWidget {
  const CartScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          iconSize: SizeConfig.width * 0.06,
          iconColor: Colors.black54,
          onPressed: () {
            context.popScreen();
          },
          hPadding: SizeConfig.width * 0.03,
          vPadding: SizeConfig.height * 0.03,
          backgroundColor: Colors.white38,
          child: Icon(Icons.arrow_back),
        ),
        Text("My Cart", style: AppTextStyles.title20BlackBold),
        CustomIconButton(
          iconSize: SizeConfig.width * 0.06,
          iconColor: Colors.black54,
          onPressed: () {
            // context.pushScreen(RouteNames.cartScreen);
          },
          hPadding: SizeConfig.width * 0.03,
          vPadding: SizeConfig.height * 0.03,
          backgroundColor: Colors.white38,
          child: Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }
}
