import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:disan/features/admin/edit_product/views/widgets/edit_product_screen_body.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var product = ProductModel.fromJson(args);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: EditProductScreenBody(product: product),
    );
  }
}

