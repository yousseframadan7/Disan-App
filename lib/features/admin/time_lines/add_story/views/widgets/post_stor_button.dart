import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostStoryButton extends StatelessWidget {
  const PostStoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddStoryAndReelsCubit, Object>(
      builder: (context, _) {
        final cubit = context.read<AddStoryAndReelsCubit>();
        if (cubit.status == AddStoryAndReelsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (cubit.mediaFile != null || cubit.storyText.isNotEmpty) {
          return Positioned(
            top: SizeConfig.height * 0.07,
            right: SizeConfig.width * 0.05,
            child: ElevatedButton.icon(
              onPressed: () => cubit.postStory(context),
              icon: Icon(Icons.send, size: SizeConfig.width * 0.05),
              label: Text(
                'Post',
                style: AppTextStyles.title18WhiteW500,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kSecondaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.05,
                    vertical: SizeConfig.height * 0.01),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
