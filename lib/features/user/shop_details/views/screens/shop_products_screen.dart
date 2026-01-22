import 'package:disan/features/user/shop_details/views/widgets/shop_products_screen_body.dart';
import 'package:flutter/material.dart';

class ShopDetailsScreen extends StatelessWidget {
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ShopProductsScreenBody(
        shopId: args,
      ),
    );
  }
}








