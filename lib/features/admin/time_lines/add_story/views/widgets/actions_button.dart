import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/pick_media_button.dart';
import 'package:disan/features/admin/time_lines/add_story/views/widgets/text_editing_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ActionsButton extends StatelessWidget {
  const ActionsButton({
    super.key,
    required this.timeLineType,
  });
  final String timeLineType;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: SizeConfig.height * 0.05,
      left: SizeConfig.width * 0.05,
      right: SizeConfig.width * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          timeLineType == 'Story'
              ? PickMediaButton(
                  icon: Icons.photo,
                  label: 'Gallery',
                  source: ImageSource.gallery,
                  isVideo: false,
                )
              : Expanded(child: Container()),
          timeLineType == 'Story'
              ? PickMediaButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  source: ImageSource.camera,
                  isVideo: false,
                )
              : Expanded(child: Container()),
          PickMediaButton(
            icon: Icons.videocam,
            label: 'Video',
            source: ImageSource.gallery,
            isVideo: true,
          ),
          timeLineType == 'Story'
              ? TextEditingButton()
              : Expanded(
                  flex: 2,
                  child: Container(),
                ),
        ],
      ),
    );
  }
}
