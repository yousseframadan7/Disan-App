import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class OfferGradient extends StatelessWidget {
  const OfferGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: SizeConfig.height * 0.14,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
      ),
    );
  }
}

