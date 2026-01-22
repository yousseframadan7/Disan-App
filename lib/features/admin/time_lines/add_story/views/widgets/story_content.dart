import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/animated_wrapper.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/update_text_position_gesture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryContent extends StatelessWidget {
  const StoryContent({
    super.key, required this.timeLineType,
  });
    final String timeLineType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AddStoryAndReelsCubit, Object>(
        builder: (context, _) {
          final cubit = context.read<AddStoryAndReelsCubit>();
          return GestureDetector(
            onTap: cubit.mediaFile != null
                ? () => cubit.startTextEditing()
                : null,
            child: AnimationWrapper(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                  image: cubit.mediaFile != null
                      ? DecorationImage(
                          image: FileImage(cubit.mediaFile!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Stack(
                  children: [
                    if (cubit.mediaFile == null &&
                        !cubit.isTextEditing &&
                        cubit.storyText.isEmpty)
                      Center(
                        child: Text('Tap to add a $timeLineType',
                            style: AppTextStyles.title24WhiteBold),
                      ),
                    if (cubit.storyText.isNotEmpty && !cubit.isTextEditing)
                      UpdateTextPositionGesture(
                        storyText: cubit.storyText,
                        textPosition: cubit.textPosition,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
