import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveTextButton extends StatelessWidget {
  const SaveTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.check, color: AppColors.kPrimaryColor),
      onPressed: () => context.read<AddStoryAndReelsCubit>().saveText(),
    );
  }
}
