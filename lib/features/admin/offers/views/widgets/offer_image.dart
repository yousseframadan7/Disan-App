import 'package:cached_network_image/cached_network_image.dart';
import 'package:disan/core/utilies/assets/images/app_images.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class OfferImage extends StatelessWidget {
  const OfferImage({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeConfig.width * 0.04),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? AppImages.welcomeImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (_, __) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (_, __, ___) => Image.asset(
          AppImages.welcomeImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        color: Colors.black.withOpacity(0.3),
        colorBlendMode: BlendMode.darken,
      ),
    );
  }
}
