import 'package:flutter/material.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';

class ProductMapCard extends StatelessWidget {
  const ProductMapCard({
    super.key,
    required this.product,
    required this.onTapToggleFavorite,
    required this.isFavorite,
    required this.onPressedCard,
  });

  final Map<String, dynamic> product;
  final void Function() onTapToggleFavorite;
  final bool isFavorite;
  final void Function() onPressedCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedCard,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
          color: Colors.white,
          elevation: 6,
          borderRadius: BorderRadius.circular(10),
          shadowColor: Colors.black,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: product['image_url'] != null
                                ? DecorationImage(
                                    image: NetworkImage(product['image_url']),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            color: Colors.grey[200],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: SizeConfig.height * 0.005,
                          right: SizeConfig.width * 0.015,
                          child: GestureDetector(
                            onTap: onTapToggleFavorite,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.all(SizeConfig.width * 0.01),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.9),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: isFavorite
                                    ? AppColors.kSecondaryColor
                                    : Colors.grey,
                                size: SizeConfig.width * 0.05,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width * 0.02,
                      vertical: SizeConfig.height * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'] ?? 'No Name',
                          style: AppTextStyles.title18BlackBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product['description'] ?? '',
                          style: AppTextStyles.title12BlackColorW400,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: SizeConfig.height * 0.01),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width * 0.015,
                                vertical: SizeConfig.height * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                "${product['price'] ?? 0} LE",
                                style: AppTextStyles.title12WhiteW500,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.star_outline_rounded,
                              color: Colors.amber.shade700,
                              size: SizeConfig.width * 0.05,
                            ),
                            Text(
                              '(4.5)',
                              style: AppTextStyles.title14BlackColorW400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
