import 'package:disan/features/user/cart/views/widgets/cart_screen_body.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CartScreenBody(),
    );
  }
}


