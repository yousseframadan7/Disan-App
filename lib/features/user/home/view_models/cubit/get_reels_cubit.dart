import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/features/admin/time_lines/reel/models/reel_model.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_reels_state.dart';

class GetReelsCubit extends Cubit<GetReelsState> {
  GetReelsCubit() : super(GetReelsInitial()) {
    getReels();
  }

  List<ReelModel> reels = [];

  final supabase = getIt<SupabaseClient>();

  /// عدد المحاولات
  int retryCount = 0;

  Future<void> getReels() async {
    try {
      emit(GetReelsLoading());

      final response = await supabase.from("reels").select();

      final List<ReelModel> tempReels =
          (response as List).map((e) => ReelModel.fromJson(e)).toList();

      final updatedReels = await Future.wait(tempReels.map((reel) async {
        try {
          final userResponse = await supabase
              .from('users')
              .select()
              .eq('id', reel.shopId)
              .single();
          return reel.copyWith(
            userModel: UserModel.fromJson(userResponse),
          );
        } catch (e) {
          log('Error fetching user for reel ${reel.shopId}: $e');
          return reel;
        }
      }).toList());

      reels = updatedReels;
      retryCount = 0; // reset retries on success
      emit(GetReelsSuccess());
    } catch (e) {
      _handleError('Error fetching reels: $e');
    }
  }

  /// دالة المسؤولة عن معالجة الأخطاء مع إعادة المحاولة
  void _handleError(String error) {
    if (retryCount < 3) {
      retryCount++;
      log("Retry attempt $retryCount after error: $error");
      emit(GetReelsLoading());

      Future.delayed(const Duration(seconds: 1), () {
        getReels();
      });
    } else {
      emit(GetReelsFailure(error: error));
    }
  }
}
