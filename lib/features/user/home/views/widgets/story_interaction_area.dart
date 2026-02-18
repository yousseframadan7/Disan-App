import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/home/view_models/cubit/story_cubit.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoryInteractionArea extends StatelessWidget {
  const StoryInteractionArea({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoryCubit>();
    final story = cubit.storyList[cubit.currentIndex];
    return Positioned(
      bottom: SizeConfig.height * 0.02,
      left: SizeConfig.width * 0.05,
      right: SizeConfig.width * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.height * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.content,
                  style: AppTextStyles.title16White500.copyWith(
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black54,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  maxLines: cubit.isExpanded[cubit.currentIndex] ?? false
                      ? null
                      : 5,
                  overflow: TextOverflow.ellipsis,
                ),
                if (story.content.length > 100)
                  GestureDetector(
                    onTap: () => cubit.toggleExpand(cubit.currentIndex),
                    child: Text(
                      cubit.isExpanded[cubit.currentIndex] ?? false
                          ? LocaleKeys.read_less.tr()
                          : LocaleKeys.read_more.tr(),
                      style: AppTextStyles.title14BlueBold,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showToast('Coming soon');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width * 0.03,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        enabled: false,
                        border: InputBorder.none,
                        hintText: LocaleKeys.write_your_reply.tr(),
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.02),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.6),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: SizeConfig.width * 0.07,
                  ),
                  onPressed: () => cubit.likeStory(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
