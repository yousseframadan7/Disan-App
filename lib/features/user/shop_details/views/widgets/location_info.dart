import 'package:disan/core/components/custom_text_button.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
      child: Card(
        color: Colors.transparent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.width * 0.04),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: SizeConfig.width * 0.07,
              ),
              SizedBox(width: SizeConfig.width * 0.03),
              Expanded(
                child: Text(
                  location,
                  style: AppTextStyles.title18Black54,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.02),
              CustomTextButton(
                title: 'View on map',
                onPressed: () {
                  showToast('Coming soon');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
