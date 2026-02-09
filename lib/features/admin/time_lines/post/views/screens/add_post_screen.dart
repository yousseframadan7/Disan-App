import 'dart:io';
import 'package:disan/core/components/custom_text_button.dart';
import 'package:disan/core/components/quick_alert.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/features/admin/time_lines/post/view_models/cubit/add_post_cubit.dart';
import 'package:disan/features/user/home/views/screens/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:quickalert/models/quickalert_type.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController postController = TextEditingController();

    return BlocProvider(
      create: (_) => AddPostCubit(),
      child: BlocConsumer<AddPostCubit, AddPostState>(
        listener: (context, state) {
          if (state is AddPostFailure) {
            quickAlert(
              type: QuickAlertType.error,
              text: state.error,
              title: "Error",
            );
          } else if (state is AddPostSuccess) {
            context.popScreen();
            quickAlert(
              type: QuickAlertType.success,
              text: "Post Added Successfully",
              title: "Success",
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddPostCubit>();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Create Post', style: AppTextStyles.title18BlackBold),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.black87),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.04,
                    vertical: SizeConfig.height * 0.015,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.submitPost();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width * 0.04,
                      ),
                    ),
                    child: state is AddPostLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text('Post',
                            style: AppTextStyles.title14BlackColorW400.copyWith(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: SizeConfig.width * 0.07,
                          backgroundImage: NetworkImage(
                            getIt<CacheHelper>().getUserModel()!.image,
                          ),
                          backgroundColor: Colors.grey.shade100,
                        ),
                        SizedBox(width: SizeConfig.width * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getIt<CacheHelper>().getUserModel()!.name,
                                style: AppTextStyles.title16BlackBold.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: SizeConfig.height * 0.005),
                              Row(
                                children: [
                                  Icon(Icons.public,
                                      color: Colors.grey.shade600, size: 14),
                                  SizedBox(width: SizeConfig.width * 0.01),
                                  Text(
                                    'Public',
                                    style: AppTextStyles.title12BlackColorW400
                                        .copyWith(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.height * 0.02),
                    PostTextField(
                      controller: cubit.postContentController,
                      hintText: "What's on your mind?",
                      maxLines: 5,
                    ),
                    SizedBox(height: SizeConfig.height * 0.02),
                    if (cubit.selectedImage != null)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              cubit.selectedImage!,
                              width: double.infinity,
                              height: SizeConfig.height * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => cubit.removeImage(),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: SizeConfig.height * 0.02),
                    InputActionButton(
                      icon: Icons.photo,
                      label: 'Photo',
                      color: Colors.green,
                      onTap: () => cubit.pickImage(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const InputActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.04,
          vertical: SizeConfig.height * 0.012,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(width: SizeConfig.width * 0.02),
            Text(
              label,
              style: AppTextStyles.title14BlackColorW400.copyWith(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
