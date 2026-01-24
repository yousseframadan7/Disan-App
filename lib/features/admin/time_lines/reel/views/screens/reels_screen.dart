import 'dart:async';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/components/cutom_out_line_button.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/date_picker.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/time_lines/reel/models/reel_model.dart';
import 'package:disan/features/admin/time_lines/reel/view_models/cubit/reels_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatefulWidget {
  final List<ReelModel> reels;
  final int initialIndex;
  const ReelsScreen(
      {super.key, required this.reels, required this.initialIndex});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late PageController _pageController;
  late ReelCubit cubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    cubit = ReelCubit(reels: widget.reels, currentIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    cubit.pauseVideo();
    cubit.close();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<ReelCubit, ReelStatus>(
          builder: (context, state) {
            final cubit = context.read<ReelCubit>();
            if (cubit.reels.isEmpty) {
              return const Center(
                child: Text(
                  'No reels available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: cubit.reels.length,
              onPageChanged: (index) {
                cubit.initializeVideo(index: index);
                setState(() {}); // تحديث UI عند تغيير الصفحة
              },
              itemBuilder: (context, index) {
                final reel = cubit.reels[index];
                if (state == ReelStatus.error) {
                  return Center(
                    child: Text(
                      "Error loading reel ${reel.id}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (cubit.videoController == null ||
                    !cubit.videoController!.value.isInitialized) {
                  return const Center(child: CircularProgressIndicator());
                }

                return BlocBuilder<ReelCubit, ReelStatus>(
                  bloc: cubit,
                  builder: (context, reelState) {
                    // جيب الـ reel المحدث من الـ cubit
                    final updatedReel = cubit.reels[index];
                    return Stack(
                      children: [
                        SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: cubit.videoController!.value.size.width,
                              height: cubit.videoController!.value.size.height,
                              child: VideoPlayer(cubit.videoController!),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: SizeConfig.height * 0.05,
                          left: SizeConfig.width * 0.05,
                          right: SizeConfig.width * 0.05,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: SizeConfig.width * 0.05,
                                backgroundImage: NetworkImage(updatedReel.userModel!.image),
                                backgroundColor: Colors.grey.shade100,
                              ),
                              SizedBox(width: SizeConfig.width * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      updatedReel.userModel!.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      updatedReel.caption ?? "No caption",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: SizeConfig.width * 0.04),
                              CustomOutLineButton(
                                onPressed: () {
                                  showToast('Coming soon');
                                },
                                name: 'Follow',
                                height: SizeConfig.height * 0.04,
                                width: SizeConfig.width * 0.2,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: SizeConfig.width * 0.05,
                          bottom: SizeConfig.height * 0.05,
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  updatedReel.likedByMe ? Icons.favorite : Icons.favorite_border,
                                  color: updatedReel.likedByMe ? Colors.red : Colors.white,
                                ),
                                onPressed: () async {
                                  // استدعاء الـ toggleLike
                                  await cubit.toggleLike(updatedReel.id);
                                  // إضافة setState لفرض إعادة بناء الـ UI فوراً
                                  // ده هيحل مشكلة عدم التحديث رغم تغيير الـ state
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                              ),
                              Text(
                                '${updatedReel.likesNum}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: SizeConfig.height * 0.02),
                              IconButton(
                                icon: const Icon(Icons.comment, color: Colors.white),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => CommentBottomSheet(
                                      reel: updatedReel,
                                      reelCubit: cubit,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                '${updatedReel.commentsCount}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: SizeConfig.height * 0.02),
                              IconButton(
                                icon: const Icon(Icons.more_horiz, color: Colors.white),
                                onPressed: () {
                                  showToast('Coming soon');
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  final ReelModel reel;
  final ReelCubit reelCubit;

  const CommentBottomSheet({super.key, required this.reel, required this.reelCubit});

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.reelCubit.streamComments(widget.reel.id);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    widget.reelCubit.streamComments(widget.reel.id);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(SizeConfig.width * 0.05),
            ),
          ),
          child: BlocProvider.value(
            value: widget.reelCubit,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: SizeConfig.width * 0.1,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.reel.commentsCount} Comments',
                        style: AppTextStyles.title16BlackBold.copyWith(
                          fontSize: SizeConfig.width * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey.shade600,
                          size: SizeConfig.width * 0.06,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade200,
                  thickness: SizeConfig.width * 0.00125,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: AppColors.kPrimaryColor,
                    child: BlocBuilder<ReelCubit, ReelStatus>(
                      bloc: widget.reelCubit,
                      builder: (context, state) {
                        if (state == ReelStatus.commentsLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (state == ReelStatus.commentsError) {
                          return Center(
                            child: Text(
                              'Error loading comments for reel ${widget.reel.id}',
                              style: AppTextStyles.title14BlackColorW400.copyWith(
                                color: Colors.grey.shade600,
                                fontSize: SizeConfig.width * 0.035,
                              ),
                            ),
                          );
                        }
                        final comments = widget.reelCubit.comments;
                        if (comments.isEmpty) {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: SizeConfig.height * 0.5,
                              child: Center(
                                child: Text(
                                  'No comments yet!',
                                  style: AppTextStyles.title14BlackColorW400.copyWith(
                                    color: Colors.grey.shade600,
                                    fontSize: SizeConfig.width * 0.035,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: SizeConfig.width * 0.05,
                                    backgroundImage: comment.user != null
                                        ? NetworkImage(comment.user!.image)
                                        : null,
                                    backgroundColor: Colors.grey.shade100,
                                  ),
                                  SizedBox(width: SizeConfig.width * 0.03),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              comment.user?.name ?? 'Unknown User',
                                              style: AppTextStyles.title14BlackColorW400.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: SizeConfig.width * 0.035,
                                              ),
                                            ),
                                            SizedBox(width: SizeConfig.width * 0.015),
                                            Text(
                                              DateHelper.formatTimeAgo(
                                                comment.createdAt,
                                                locle: context.locale.languageCode,
                                              ),
                                              style: AppTextStyles.title12BlackColorW400.copyWith(
                                                color: Colors.grey.shade600,
                                                fontSize: SizeConfig.width * 0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: SizeConfig.height * 0.005),
                                        Text(
                                          comment.content,
                                          style: AppTextStyles.title14BlackColorW400.copyWith(
                                            fontSize: SizeConfig.width * 0.035,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(SizeConfig.width * 0.04).add(
                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: SizeConfig.width * 0.05,
                          backgroundImage: NetworkImage(
                              getIt<CacheHelper>().getUserModel()?.image ?? ''),
                          backgroundColor: Colors.grey.shade100,
                        ),
                        SizedBox(width: SizeConfig.width * 0.03),
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(SizeConfig.width * 0.03),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: AppTextStyles.title14BlackColorW400.copyWith(
                                color: Colors.grey.shade600,
                                fontSize: SizeConfig.width * 0.035,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width * 0.04,
                                vertical: SizeConfig.height * 0.015,
                              ),
                            ),
                            style: AppTextStyles.title14BlackColorW400.copyWith(
                              color: Colors.black87,
                              fontSize: SizeConfig.width * 0.0375,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(width: SizeConfig.width * 0.03),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: AppColors.kPrimaryColor,
                            size: SizeConfig.width * 0.06,
                          ),
                          onPressed: () {
                            if (_commentController.text.trim().isNotEmpty) {
                              widget.reelCubit.addComment(
                                reelId: widget.reel.id,
                                comment: _commentController.text.trim(),
                              ).then((_) {
                                showToast('Comment added successfully');
                              });
                              _commentController.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}