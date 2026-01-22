import 'package:cached_network_image/cached_network_image.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/time_lines/story/models/story_model.dart';
import 'package:disan/features/user/home/view_models/cubit/story_cubit.dart';
import 'package:disan/features/user/home/view_models/cubit/story_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class StoryContent extends StatelessWidget {
  final List<StoryModel> stories;

  const StoryContent({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: stories.length,
          controller: context.read<StoryCubit>().pageController,
          itemBuilder: (context, index) {
            final story = stories[index];
            final cubit = context.read<StoryCubit>();
            Widget contentWidget;

            if (story.type == MediaType.text) {
              contentWidget = Container(
                color: Colors.black,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width * 0.05,
                      vertical: SizeConfig.height * 0.01,
                    ),
                    child: Text(
                      story.content,
                      style: AppTextStyles.title24WhiteW500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
              if (cubit.currentIndex == index && !cubit.isContentLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  cubit.loadStory(story: story, animateToPage: false);
                });
              }
            } else if (story.type == MediaType.image) {
              if (cubit.isValidUrl(story.url)) {
                contentWidget = CachedNetworkImage(
                  imageUrl: story.url!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error, color: Colors.white)),
                  imageBuilder: (context, imageProvider) {
                    if (cubit.currentIndex == index && !cubit.isContentLoaded) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        cubit.onImageLoaded();
                      });
                    }
                    return Image(image: imageProvider, fit: BoxFit.cover);
                  },
                );
              } else {
                contentWidget =
                    const Center(child: Icon(Icons.error, color: Colors.white));
                if (cubit.currentIndex == index && !cubit.isContentLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    cubit.loadStory(story: story, animateToPage: false);
                  });
                }
              }
            } else if (story.type == MediaType.video) {
              if (cubit.videoPlayerController != null &&
                  cubit.videoPlayerController!.value.isInitialized) {
                contentWidget = FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: cubit.videoPlayerController!.value.size.width,
                    height: cubit.videoPlayerController!.value.size.height,
                    child: VideoPlayer(cubit.videoPlayerController!),
                  ),
                );
              } else {
                contentWidget =
                    const Center(child: CircularProgressIndicator());
              }
            } else {
              contentWidget = const SizedBox.shrink();
            }
            return contentWidget;
          },
        ),
        if (context.read<StoryCubit>().status == StoryStatus.completed)
        if (context.read<StoryCubit>().status == StoryStatus.error)
          Center(
              child: Text('Error: ${context.read<StoryCubit>().error}',
                  style: TextStyle(color: Colors.red))),
        if (context.read<StoryCubit>().status == StoryStatus.loading &&
            context.read<StoryCubit>().isContentLoaded == false)
          Center(
              child: CircularProgressIndicator(color: AppColors.kPrimaryColor)),
      ],
    );
  }
}
