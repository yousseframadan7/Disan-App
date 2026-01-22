import 'package:disan/features/admin/time_lines/story/models/story_model.dart';
import 'package:disan/features/user/home/view_models/cubit/story_cubit.dart';
import 'package:disan/features/user/home/views/widgets/story_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryGestureHandler extends StatelessWidget {
  final List<StoryModel> stories;

  const StoryGestureHandler({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) =>
          context.read<StoryCubit>().handleTap(details, context),
      onLongPress: () => context.read<StoryCubit>().handleLongPress(),
      onLongPressEnd: (_) => context.read<StoryCubit>().handleLongPressEnd(),
      child: StoryContent(stories: stories),
    );
  }
}
