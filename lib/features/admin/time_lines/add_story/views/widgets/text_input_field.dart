import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/save_text_button.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddStoryAndReelsCubit, Object>(
      builder: (context, _) {
        final cubit = context.read<AddStoryAndReelsCubit>();
        if (cubit.isTextEditing) {
          return Positioned(
            bottom: SizeConfig.height * 0.13,
            left: SizeConfig.width * 0.05,
            right: SizeConfig.width * 0.05,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.02,
                vertical: SizeConfig.height * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cubit.textController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Type your story...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: AppTextStyles.title18BlackBold,
                      maxLines: null,
                    ),
                  ),
                  SaveTextButton(),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
