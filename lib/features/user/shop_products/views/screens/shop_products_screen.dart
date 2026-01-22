import 'package:disan/core/components/custom_app_bar.dart';
import 'package:disan/features/user/shop_products/views/widgets/shop_products_screen_body.dart';
import 'package:flutter/material.dart';

class ShopProductsScreen extends StatelessWidget {
  const ShopProductsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(shopName: "Products"),
      body: ShopProductsScreenBody(shopId: args),
    );
  }
}
