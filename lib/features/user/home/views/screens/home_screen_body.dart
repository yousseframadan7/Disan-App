import 'dart:developer';
import 'dart:io';
import 'package:disan/app/cubit/localization_cubit.dart';
import 'package:disan/core/app_route/route_names.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/components/show_toast.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/date_picker.dart';
import 'package:disan/core/utilies/colors/app_colors.dart';
import 'package:disan/core/utilies/extensions/app_extensions.dart';
import 'package:disan/core/utilies/sizes/sized_config.dart';
import 'package:disan/core/utilies/styles/app_text_styles.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_failure_message.dart';
import 'package:disan/features/admin/customer_requests_details/views/widgets/custom_loading.dart';
import 'package:disan/features/admin/time_lines/reel/models/reel_model.dart';
import 'package:disan/features/admin/time_lines/reel/views/screens/reels_screen.dart';
import 'package:disan/features/admin/time_lines/story/models/story_model.dart';
import 'package:disan/features/user/home/models/post_model.dart';
import 'package:disan/features/user/home/view_models/cubit/get_reels_cubit.dart';
import 'package:disan/features/user/home/view_models/cubit/get_stories_cubit.dart';
import 'package:disan/features/user/home/view_models/cubit/post_cubit.dart';
import 'package:disan/features/user/home/views/widgets/story_screen.dart';
import 'package:disan/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class TimeLinesTab extends StatelessWidget {
  const TimeLinesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<PostCubit>().getPosts();
      },
      color: AppColors.kPrimaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.03,
          vertical: SizeConfig.height * 0.01,
        ),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                getIt<CacheHelper>().getUserModel()!.role == "shop"
                    ? const PostInputField()
                    : const SizedBox(),
                getIt<CacheHelper>().getUserModel()!.role == "shop"
                    ? SizedBox(height: SizeConfig.height * 0.02)
                    : const SizedBox(),
                SectionTitle(title: LocaleKeys.stories.tr()),
                SizedBox(height: SizeConfig.height * 0.015),
              ]),
            ),
            const SliverToBoxAdapter(child: StoriesList()),
            SliverToBoxAdapter(
              child: CustomDivider(topSpacing: SizeConfig.height * 0.00),
            ),
            SliverPadding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SectionTitle(title: LocaleKeys.reels.tr()),
                  SizedBox(height: SizeConfig.height * 0.02),
                ]),
              ),
            ),
            const SliverToBoxAdapter(child: SuggestedReelsList()),
            SliverToBoxAdapter(
              child: CustomDivider(topSpacing: SizeConfig.height * 0.02),
            ),
            const PostsListView(),
          ],
        ),
      ),
    );
  }
}

class PostsListView extends StatelessWidget {
  const PostsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, GetPostsState>(
      builder: (context, state) {
        if (state is GetPostsLoading) {
          return SliverToBoxAdapter(child: const CustomLoading());
        }
        if (state is GetPostsFailure) {
          return SliverToBoxAdapter(
              child: CustomFailureMesage(errorMessage: state.error));
        }
        final posts = context.read<PostCubit>().posts;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: posts.length,
            (context, index) => PostCard(post: posts[index]),
          ),
        );
      },
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.title20BlackBold.copyWith(
        fontSize: SizeConfig.width * 0.045,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double? topSpacing;
  final double? bottomSpacing;

  const CustomDivider({super.key, this.topSpacing, this.bottomSpacing});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topSpacing ?? SizeConfig.height * 0.005),
        Divider(
          color: Colors.grey.shade200,
          thickness: SizeConfig.width * 0.002,
          indent: SizeConfig.width * 0.02,
          endIndent: SizeConfig.width * 0.02,
        ),
        SizedBox(height: bottomSpacing ?? SizeConfig.height * 0.005),
      ],
    );
  }
}

class PostInputField extends StatelessWidget {
  const PostInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: SizeConfig.width * 0.008,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.width * 0.04),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.width * 0.04),
        child: Row(
          children: [
            CircleAvatar(
              radius: SizeConfig.width * 0.07,
              backgroundImage: NetworkImage(
                  getIt<CacheHelper>().getUserModel()?.image ?? ''),
              backgroundColor: Colors.grey.shade100,
            ),
            SizedBox(width: SizeConfig.width * 0.03),
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.width * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: AppTextStyles.title14BlackColorW400.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: SizeConfig.width * 0.035,
                  ),
                ),
                onTap: () => context.pushScreen(RouteNames.addPostScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoriesList extends StatelessWidget {
  const StoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetStoriesCubit(),
      child: BlocBuilder<GetStoriesCubit, GetStoriesState>(
        builder: (context, state) {
          if (state is GetStoriesLoading) {
            return buildShimmerStories();
          }
          if (state is GetStoriesFailure) {
            log('GetStoriesFailure: ${state.error}');
            return buildErrorWidget(state.error, SizeConfig.height * 0.14);
          }

          final stories = context.read<GetStoriesCubit>().stories ?? [];
          final isShop = getIt<CacheHelper>().getUserModel()?.role == "shop";
          if (stories.isEmpty && !isShop) {
            return buildEmptyWidget(
                LocaleKeys.no_stories_available.tr(), SizeConfig.height * 0.14);
          }

          final displayItems = isShop ? [null, ...stories] : stories;

          return SizedBox(
            height: SizeConfig.height * 0.14,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: displayItems.length,
              itemBuilder: (context, index) {
                if (isShop && index == 0) {
                  return buildAddStoryButton(context);
                }
                final story = displayItems[index] as StoryModel?;
                if (story == null || story.user == null) {
                  log('Null story or user at index: $index');
                  return const SizedBox.shrink();
                }
                return buildStoryItem(context, story, isShop, stories, index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmerStories() {
    return SizedBox(
      height: SizeConfig.height * 0.14,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: SizeConfig.width * 0.035),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.width * 0.18,
                    height: SizeConfig.width * 0.18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: SizeConfig.height * 0.01),
                  Container(
                    width: SizeConfig.width * 0.14,
                    height: SizeConfig.height * 0.015,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAddStoryButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushScreen(RouteNames.addStoryAndReelsScreen,
          arguments: "Story"),
      child: Padding(
        padding: EdgeInsets.only(right: SizeConfig.width * 0.035),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.kSecondaryColor,
                    AppColors.kPrimaryColor,
                    AppColors.kThirdColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(SizeConfig.width * 0.008),
              child: CircleAvatar(
                radius: SizeConfig.width * 0.08,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Colors.black87,
                  size: SizeConfig.width * 0.08,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.height * 0.01),
            Text(
              LocaleKeys.add_story.tr(),
              style: AppTextStyles.title12BlackColorW400.copyWith(
                fontSize: SizeConfig.width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStoryItem(
    BuildContext context,
    StoryModel story,
    bool isShop,
    List<StoryModel> stories,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryScreen(
              stories: stories,
              initialIndex: isShop ? index - 1 : index,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: SizeConfig.width * 0.035),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.kSecondaryColor,
                    AppColors.kPrimaryColor,
                    AppColors.kThirdColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.all(SizeConfig.width * 0.008),
              child: CircleAvatar(
                radius: SizeConfig.width * 0.08,
                backgroundImage:
                    story.url != '0' ? NetworkImage(story.user!.image) : null,
                backgroundColor:
                    story.url == '0' ? Colors.blueAccent : Colors.grey.shade100,
                child: story.url == '0'
                    ? Padding(
                        padding: EdgeInsets.all(SizeConfig.width * 0.02),
                        child: Text(
                          story.content,
                          style: AppTextStyles.title12BlackColorW400.copyWith(
                            color: Colors.white,
                            fontSize: SizeConfig.width * 0.022,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(height: SizeConfig.height * 0.01),
            Text(
              story.user!.name,
              style: AppTextStyles.title12BlackColorW400.copyWith(
                fontSize: SizeConfig.width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildErrorWidget(String message, double height) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.title14BlackColorW400.copyWith(
            color: Colors.grey.shade600,
            fontSize: SizeConfig.width * 0.035,
          ),
        ),
      ),
    );
  }

  Widget buildEmptyWidget(String message, double height) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.title14BlackColorW400.copyWith(
            color: Colors.grey.shade600,
            fontSize: SizeConfig.width * 0.035,
          ),
        ),
      ),
    );
  }
}

class SuggestedReelsList extends StatelessWidget {
  const SuggestedReelsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetReelsCubit(),
      child: BlocBuilder<GetReelsCubit, GetReelsState>(
        builder: (context, state) {
          if (state is GetReelsLoading) {
            return buildShimmerReels();
          }
          if (state is GetReelsFailure) {
            log('GetReelsFailure: ${state.error}');
            return buildErrorWidget(state.error, SizeConfig.height * 0.28);
          }

          final reels = context.read<GetReelsCubit>().reels ?? [];
          final isShop = getIt<CacheHelper>().getUserModel()?.role == "shop";
          if (reels.isEmpty && !isShop) {
            return buildEmptyWidget(
                LocaleKeys.no_reels_available.tr(), SizeConfig.height * 0.28);
          }

          final displayItems = isShop ? [null, ...reels] : reels;

          return SizedBox(
            height: SizeConfig.height * 0.28,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.02),
              itemCount: displayItems.length,
              itemBuilder: (context, index) {
                if (isShop && index == 0) {
                  return buildAddReelButton(context);
                }
                final reel = displayItems[index] as ReelModel?;
                if (reel == null) {
                  log('Null reel at index: $index');
                  return const SizedBox.shrink();
                }
                return buildReelItem(context, reel, isShop, reels, index);
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildShimmerReels() {
    return SizedBox(
      height: SizeConfig.height * 0.28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.02),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: SizeConfig.width * 0.4,
              height: SizeConfig.height * 0.28,
              margin: EdgeInsets.only(right: SizeConfig.width * 0.03),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.width * 0.035),
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: SizeConfig.width * 0.125,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildAddReelButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushScreen(RouteNames.addStoryAndReelsScreen,
          arguments: "Reel"),
      child: Container(
        width: SizeConfig.width * 0.4,
        height: SizeConfig.height * 0.28,
        margin: EdgeInsets.only(right: SizeConfig.width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.width * 0.035),
          gradient: LinearGradient(
            colors: [
              AppColors.kSecondaryColor,
              AppColors.kPrimaryColor,
              AppColors.kThirdColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(SizeConfig.width * 0.008),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SizeConfig.width * 0.03),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                color: Colors.black87,
                size: SizeConfig.width * 0.12,
              ),
              SizedBox(height: SizeConfig.height * 0.015),
              Text(
                LocaleKeys.add_reel.tr(),
                style: AppTextStyles.title12BlackColorW400.copyWith(
                  fontSize: SizeConfig.width * 0.035,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReelItem(
    BuildContext context,
    ReelModel reel,
    bool isShop,
    List<ReelModel> reels,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReelsScreen(
              reels: reels,
              initialIndex: isShop ? index - 1 : index,
            ),
          ),
        );
      },
      child: Container(
        width: SizeConfig.width * 0.4,
        height: SizeConfig.height * 0.28,
        margin: EdgeInsets.only(right: SizeConfig.width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.width * 0.035),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: SizeConfig.width * 0.015,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SizeConfig.width * 0.035),
          child: Stack(
            children: [
              ThumbnailWidget(videoUrl: reel.videoUrl),
              Positioned(
                bottom: SizeConfig.height * 0.01,
                right: SizeConfig.width * 0.02,
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.width * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: SizeConfig.width * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildErrorWidget(String message, double height) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.title14BlackColorW400.copyWith(
            color: Colors.grey.shade600,
            fontSize: SizeConfig.width * 0.035,
          ),
        ),
      ),
    );
  }

  Widget buildEmptyWidget(String message, double height) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          message,
          style: AppTextStyles.title14BlackColorW400.copyWith(
            color: Colors.grey.shade600,
            fontSize: SizeConfig.width * 0.035,
          ),
        ),
      ),
    );
  }
}

class ThumbnailWidget extends StatelessWidget {
  final String videoUrl;
  const ThumbnailWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: VideoThumbnail.thumbnailFile(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxHeight: (SizeConfig.height * 0.25).toInt(),
        quality: 75,
        timeMs: 0,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null &&
            File(snapshot.data!).existsSync()) {
          return Image.file(
            File(snapshot.data!),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              log('Image.file error: $error');
              return const SimpleFallbackThumbnail();
            },
          );
        }
        return const SimpleFallbackThumbnail();
      },
    );
  }
}

class SimpleFallbackThumbnail extends StatelessWidget {
  const SimpleFallbackThumbnail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(SizeConfig.width * 0.035),
      ),
      child: Center(
        child: Icon(
          Icons.videocam_off,
          color: Colors.grey.shade500,
          size: SizeConfig.width * 0.1,
        ),
      ),
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  final PostModel post;
  final PostCubit postCubit;

  const CommentBottomSheet(
      {super.key, required this.post, required this.postCubit});

  @override
  _CommentBottomSheetState createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.postCubit.streamComments(widget.post.id);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    widget.postCubit.getPosts();
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
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: SizeConfig.height * 0.015),
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
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.post.commentsCount} Comments',
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
                  child: BlocBuilder<PostCubit, GetPostsState>(
                    bloc: widget.postCubit,
                    builder: (context, state) {
                      if (state is GetCommentsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetCommentsFailure) {
                        return Center(
                          child: Text(
                            state.error,
                            style: AppTextStyles.title14BlackColorW400.copyWith(
                              color: Colors.grey.shade600,
                              fontSize: SizeConfig.width * 0.035,
                            ),
                          ),
                        );
                      }
                      final comments = widget.postCubit.comments;
                      if (comments.isEmpty) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: SizeConfig.height * 0.5,
                            child: Center(
                              child: Text(
                                'No comments yet',
                                style: AppTextStyles.title14BlackColorW400
                                    .copyWith(
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
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width * 0.04),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.height * 0.01),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            comment.user?.name ??
                                                'Unknown User',
                                            style: AppTextStyles
                                                .title14BlackColorW400
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  SizeConfig.width * 0.035,
                                            ),
                                          ),
                                          SizedBox(
                                              width: SizeConfig.width * 0.015),
                                          Text(
                                            DateHelper.formatTimeAgo(
                                              comment.createdAt,
                                              locle: getIt<TranslationCubit>()
                                                  .state
                                                  .languageCode,
                                            ),
                                            style: AppTextStyles
                                                .title12BlackColorW400
                                                .copyWith(
                                              color: Colors.grey.shade600,
                                              fontSize: SizeConfig.width * 0.03,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: SizeConfig.height * 0.005),
                                      Text(
                                        comment.content,
                                        style: AppTextStyles
                                            .title14BlackColorW400
                                            .copyWith(
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
                  EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        child: PostTextField(
                          controller: _commentController,
                          hintText: 'Write a comment...',
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
                            widget.postCubit.addComment(
                              postId: widget.post.id,
                              comment: _commentController.text.trim(),
                            );
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
        );
      },
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final postCubit = context.read<PostCubit>();
    return Card(
      elevation: SizeConfig.width * 0.01,
      shadowColor: Colors.grey.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.width * 0.035),
      ),
      margin: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.02),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.width * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: SizeConfig.width * 0.07,
                  backgroundImage: NetworkImage(post.user!.image),
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
                            post.user!.name,
                            style: AppTextStyles.title16BlackBold.copyWith(
                              fontSize: SizeConfig.width * 0.04,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: SizeConfig.width * 0.015),
                          Icon(
                            Icons.verified,
                            color: Colors.blueAccent,
                            size: SizeConfig.width * 0.045,
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.height * 0.005),
                      Row(
                        children: [
                          Text(
                            DateHelper.formatTimeAgo(DateTime.now(),
                                locle: getIt<TranslationCubit>()
                                    .state
                                    .languageCode),
                            style: AppTextStyles.title12BlackColorW400.copyWith(
                              color: Colors.grey.shade600,
                              fontSize: SizeConfig.width * 0.03,
                            ),
                          ),
                          Icon(
                            Icons.public,
                            color: Colors.grey.shade600,
                            size: SizeConfig.width * 0.035,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.grey.shade600,
                    size: SizeConfig.width * 0.055,
                  ),
                  onPressed: () => showToast('More options - Coming soon'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.015,
            ),
            child: Text(
              post.content,
              style: AppTextStyles.title14BlackColorW400.copyWith(
                fontSize: SizeConfig.width * 0.0375,
                color: Colors.black87,
                height: 1.4,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          post.image == null
              ? const SizedBox()
              : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.width * 0.025),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(SizeConfig.width * 0.025),
                      child: Image.network(
                        post.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(
                            Icons.image,
                            size: SizeConfig.width * 0.2,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.015,
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: SizeConfig.width * 0.04,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(width: SizeConfig.width * 0.015),
                    Text(
                      '${post.likesNum} Likes',
                      style: AppTextStyles.title14BlackColorW400.copyWith(
                        color: Colors.grey.shade700,
                        fontSize: SizeConfig.width * 0.0325,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  '${post.commentsCount} Comments',
                  style: AppTextStyles.title14BlackColorW400.copyWith(
                    color: Colors.grey.shade700,
                    fontSize: SizeConfig.width * 0.0325,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: SizeConfig.width * 0.00125,
            indent: SizeConfig.width * 0.04,
            endIndent: SizeConfig.width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.005,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _PostActionButton(
                  icon: Icons.thumb_up_outlined,
                  label: 'Like',
                  onTap: () {
                    context.read<PostCubit>().toggleLike(post.id);
                  },
                  iconColor:
                      post.likedByMe ? Colors.blueAccent : Colors.grey.shade700,
                ),
                _PostActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Comment',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => CommentBottomSheet(
                        post: post,
                        postCubit: postCubit,
                      ),
                    );
                  },
                  iconColor: Colors.grey.shade700,
                ),
                _PostActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  onTap: () => showToast('Share - Coming soon'),
                  iconColor: Colors.grey.shade700,
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.height * 0.015),
        ],
      ),
    );
  }
}

class _PostActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const _PostActionButton({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(SizeConfig.width * 0.02),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.height * 0.015,
          horizontal: SizeConfig.width * 0.03,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: SizeConfig.width * 0.055,
            ),
            SizedBox(width: SizeConfig.width * 0.015),
            Text(
              label,
              style: AppTextStyles.title14BlackColorW400.copyWith(
                color: Colors.grey.shade700,
                fontSize: SizeConfig.width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const PostTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}
