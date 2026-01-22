import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/user/home/view_models/cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoryCubit>();
    final user = cubit.storyList[cubit.currentIndex].user;
    return Positioned(
      top: SizeConfig.height * 0.05,
      left: SizeConfig.width * 0.05,
      child: Row(
        children: [
          CircleAvatar(
            radius: SizeConfig.width * 0.05,
            backgroundImage: cubit.isValidUrl(user!.image)
                ? NetworkImage(user.image)
                : null,
            child: !cubit.isValidUrl(user.image)
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          SizedBox(width: SizeConfig.width * 0.02),
          Text(
            user.name,
            style: AppTextStyles.title16WhiteBold.copyWith(
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black54,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
