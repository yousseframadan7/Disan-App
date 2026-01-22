import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_cubit.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_state.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/actions_button.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/back_button.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/gradiant_body.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/post_stor_button.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/story_content.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AddStoryAndReelsScreenBody extends StatelessWidget {
  const AddStoryAndReelsScreenBody({
    super.key,
    required this.timeLineType,
  });
  final String timeLineType;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddStoryAndReelsCubit, Object>(
      listener: (context, state) {
        final cubit = context.read<AddStoryAndReelsCubit>();
        if (cubit.status == AddStoryAndReelsStatus.success) {
          context.popScreen();
          context.popScreen();
          quickAlert(
            type: QuickAlertType.success,
            text: '$timeLineType added successfully',
          );
        }else if (cubit.status == AddStoryAndReelsStatus.initial) {
          context.popScreen();
        }
         else if (cubit.status == AddStoryAndReelsStatus.failure) {
          context.popScreen();
          quickAlert(type: QuickAlertType.error, text: cubit.error);
        } else if (cubit.status == AddStoryAndReelsStatus.invalidMedia) {
          context.popScreen();
          quickAlert(type: QuickAlertType.error, text: cubit.error);
        } else if (cubit.status == AddStoryAndReelsStatus.loading) {
          quickAlert(
            type: QuickAlertType.loading,
            text: 'Loading',
          );
        }
      },
      child: Stack(
        children: [
          GradiantBody(),
          StoryContent(
            timeLineType: timeLineType,
          ),
          TextInputField(),
          ActionsButton(timeLineType: timeLineType,),
          PostStoryButton(),
          BackIconButton(),
        ],
      ),
    );
  }
}
