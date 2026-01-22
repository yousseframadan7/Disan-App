import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickMediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final ImageSource source;
  final bool isVideo;

  const PickMediaButton({
    super.key,
    required this.icon,
    required this.label,
    required this.source,
    this.isVideo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () =>
              context.read<AddStoryAndReelsCubit>().pickMedia(source, isVideo: isVideo),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.05,
              vertical: SizeConfig.height * 0.02,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.kPrimaryColor.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child:
                Icon(icon, color: Colors.white, size: SizeConfig.width * 0.07),
          ),
        ),
        SizedBox(height: SizeConfig.height * 0.005),
        Text(label, style: AppTextStyles.title14WhiteW600),
      ],
    );
  }
}
