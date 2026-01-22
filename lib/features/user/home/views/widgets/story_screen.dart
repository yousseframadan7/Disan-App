import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/time_lines/story/models/story_model.dart';
import 'package:disan/features/user/home/view_models/cubit/story_cubit.dart';
import 'package:disan/features/user/home/view_models/cubit/story_state.dart';
import 'package:disan/features/user/home/views/widgets/animated_bar.dart';
import 'package:disan/features/user/home/views/widgets/exit_button.dart';
import 'package:disan/features/user/home/views/widgets/story_gesture_handler.dart';
import 'package:disan/features/user/home/views/widgets/story_interaction_area.dart';
import 'package:disan/features/user/home/views/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryScreen extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialIndex;

  const StoryScreen({super.key, required this.stories, this.initialIndex = 0});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoryCubit>(
      create: (context) => StoryCubit(
        stories: widget.stories,
        vsync: this,
        initialIndex: widget.initialIndex,
      ),
      child: BlocConsumer<StoryCubit, Object>(
        listener: (context, state) {
          if (context.read<StoryCubit>().status == StoryStatus.completed) {
            context.popScreen();
          }
        },
        builder: (context, _) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  StoryGestureHandler(stories: widget.stories),
                  Positioned(
                    top: SizeConfig.height * 0.025,
                    left: SizeConfig.width * 0.05,
                    right: SizeConfig.width * 0.05,
                    child: Row(
                      children: widget.stories
                          .asMap()
                          .entries
                          .map((entry) => AnimatedBar(
                                index: entry.key,
                                position:
                                    context.read<StoryCubit>().currentIndex,
                              ))
                          .toList(),
                    ),
                  ),
                  UserInfo(),
                  ExitButton(),
                  StoryInteractionArea(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
