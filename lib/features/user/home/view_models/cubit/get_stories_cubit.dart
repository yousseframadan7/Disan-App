import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/time_lines/story/models/story_model.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_stories_state.dart';

class GetStoriesCubit extends Cubit<GetStoriesState> {
  GetStoriesCubit() : super(GetStoriesInitial()) {
    emit(GetStoriesLoading());
    getStories();
  }

  List<StoryModel> stories = [];
  final supabase = getIt<SupabaseClient>();

  int retryCount = 0; // عدد المحاولات

  Future<void> getStories() async {
    try {
      emit(GetStoriesLoading());

      final response = await supabase.from("stories").select();

      final List<StoryModel> tempStories =
          (response as List).map((e) => StoryModel.fromJson(e)).toList();

      final updatedStories =
          await Future.wait(tempStories.map((story) async {
        try {
          final userResponse = await supabase
              .from('users')
              .select()
              .eq('id', story.shopId)
              .single();

          return story.copyWith(
            user: UserModel.fromJson(userResponse),
          );
        } catch (e) {
          log("Error fetching user for story ${story.shopId}: $e");
          return story;
        }
      }));

      stories = updatedStories;
      retryCount = 0; // Reset retries on success
      emit(GetStoriesSuccess());
    } catch (e) {
      _handleError('Error fetching stories: $e');
    }
  }

  void _handleError(String error) {
    if (retryCount < 3) {
      retryCount++;
      log("Stories retry attempt $retryCount after error: $error");
      emit(GetStoriesLoading());

      Future.delayed(Duration(seconds: retryCount), () {
        getStories();
      });
    } else {
      emit(GetStoriesFailure(error: error));
    }
  }
}
