import 'package:disan/core/helper/launch_link.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ContactUsCard extends StatelessWidget {
  const ContactUsCard({
    super.key,
    required this.url,
    required this.title,
    required this.icon,
    required this.subTitle,
    required this.iconColor,
  });
  final Uri url;
  final String title;
  final String subTitle;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          launchUrlSocialMedia(url: url);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.02,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: SizeConfig.width * 0.06,
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.title16BlackBold,
                    ),
                    SizedBox(height: SizeConfig.height * 0.005),
                    Text(
subTitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.width * 0.04,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
