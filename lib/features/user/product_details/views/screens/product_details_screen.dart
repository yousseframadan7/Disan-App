import 'package:disan/features/user/product_details/views/widgets/product_details_screen_body.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var product = ProductModel.fromJson(args);
    return Scaffold(
      body: ProductDetailsScreenBody(product: product),
    );
  }
}