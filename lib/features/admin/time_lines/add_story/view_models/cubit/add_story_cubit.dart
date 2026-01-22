import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:disan/core/network/supabase/database/add_data.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:disan/features/admin/time_lines/add_story/view_models/cubit/add_story_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddStoryAndReelsCubit extends Cubit<Object> {
  final SupabaseClient supabaseClient;
  final String timeLineType;
  File? _mediaFile;
  String _storyText = '';
  bool _isTextEditing = false;
  Offset _textPosition = const Offset(0, 0);
  final TextEditingController _textController = TextEditingController();
  String _url = '';
  AddStoryAndReelsStatus _status = AddStoryAndReelsStatus.initial;
  String? _error;

  // Getters for UI access
  File? get mediaFile => _mediaFile;
  String get storyText => _storyText;
  bool get isTextEditing => _isTextEditing;
  Offset get textPosition => _textPosition;
  TextEditingController get textController => _textController;
  String get url => _url;
  AddStoryAndReelsStatus get status => _status;
  String? get error => _error;

  AddStoryAndReelsCubit(
      {required this.supabaseClient, required this.timeLineType})
      : super(Object());

  @override
  Future<void> close() {
    _textController.dispose();
    return super.close();
  }

  Future<void> pickMedia(ImageSource source, {bool isVideo = false}) async {
    final picker = ImagePicker();
    try {
      if (isVideo || timeLineType == "Reel") {
        final XFile? video = await picker.pickVideo(source: source);
        if (video == null) {
          _status = AddStoryAndReelsStatus.failure;
          _error = 'No video selected';
          emit(Object());
          return;
        }
        _mediaFile = File(video.path);
        _status = AddStoryAndReelsStatus.loading;
        emit(Object());
        final uploadedUrl = await uploadFileToSupabaseStorage(file: _mediaFile!);
        if (uploadedUrl == null) {
          _status = AddStoryAndReelsStatus.failure;
          _error = 'Failed to upload video';
          emit(Object());
          return;
        }
        _url = uploadedUrl;
        _status = AddStoryAndReelsStatus.initial;
        emit(Object());
      } else {
        final XFile? image = await picker.pickImage(source: source);
        if (image == null) {
          _status = AddStoryAndReelsStatus.failure;
          _error = 'No image selected';
          emit(Object());
          return;
        }
        _mediaFile = File(image.path);
        _status = AddStoryAndReelsStatus.loading;
        emit(Object());
        final uploadedUrl = await uploadFileToSupabaseStorage(file: _mediaFile!);
        if (uploadedUrl == null) {
          _status = AddStoryAndReelsStatus.failure;
          _error = 'Failed to upload image';
          emit(Object());
          return;
        }
        _url = uploadedUrl;
        _status = AddStoryAndReelsStatus.initial;
        emit(Object());
      }
    } catch (e) {
      _status = AddStoryAndReelsStatus.failure;
      _error = 'Error picking media: $e';
      emit(Object());
    }
  }

  void startTextEditing() {
    _textController.text = _storyText;
    _isTextEditing = true;
    _status = AddStoryAndReelsStatus.initial;
    emit(Object());
  }

  void saveText() {
    _storyText = _textController.text;
    _isTextEditing = false;
    _status = AddStoryAndReelsStatus.initial;
    emit(Object());
  }

  void updateTextPosition(Offset delta) {
    _textPosition = _textPosition + delta;
    _status = AddStoryAndReelsStatus.initial;
    emit(Object());
  }

  Future<void> postStory(BuildContext context) async {
    if (_url.isEmpty && _textController.text.isEmpty) {
      _status = AddStoryAndReelsStatus.fieldsEmpty;
      emit(Object());
      return;
    }
    _status = AddStoryAndReelsStatus.loading;
    emit(Object());
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        _status = AddStoryAndReelsStatus.failure;
        _error = 'User not authenticated';
        emit(Object());
        return;
      }
      await addData(
          tableName: timeLineType == "Story" ? "stories" : "reels",
          data: {
            if (_url.isNotEmpty)
              timeLineType == "Story" ? "media_url" : "video_url": _url,
            if (_textController.text.isNotEmpty)
              "caption": _textController.text,
            "shop_id": userId,
            if (timeLineType == "Story")
              "expires_at":
                  DateTime.now().add(const Duration(hours: 24)).toIso8601String(),
          });
      _status = AddStoryAndReelsStatus.success;
      emit(Object());
    } catch (e) {
      _status = AddStoryAndReelsStatus.failure;
      _error = e.toString();
      emit(Object());
    }
  }
}
