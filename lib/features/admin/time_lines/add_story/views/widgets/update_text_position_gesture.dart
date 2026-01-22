import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTextPositionGesture extends StatelessWidget {
  final String storyText;
  final Offset textPosition;

  const UpdateTextPositionGesture({
    super.key,
    required this.storyText,
    required this.textPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: textPosition.dx,
      top: textPosition.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          context.read<AddStoryAndReelsCubit>().updateTextPosition(details.delta);
        },
        onTap: () => context.read<AddStoryAndReelsCubit>().startTextEditing(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(storyText, style: AppTextStyles.title20WhiteBold),
        ),
      ),
    );
  }
}
