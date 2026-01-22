import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/admin/offers/views/widgets/offers_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/components/custom_app_bar.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(shopName: "Offers"),
      body: const OffersScreenBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushScreen(RouteNames.discountTypeSelectionPage);
        },
        backgroundColor: AppColors.kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

