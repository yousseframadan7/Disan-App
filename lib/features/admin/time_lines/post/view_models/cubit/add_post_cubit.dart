import 'dart:io';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/core/network/supabase/database/add_data.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  final supabase = getIt<SupabaseClient>();
  final picker = ImagePicker();
  final postContentController = TextEditingController();
  File? selectedImage;

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);
        emit(AddPostImagePicked());
      }
    } catch (e) {
      emit(AddPostFailure(error: e.toString()));
    }
  }

  Future<void> submitPost() async {
    // if (postContentController.text.isNotEmpty) {
      try {
        emit(AddPostLoading());
        await addData(tableName: "blogs", data: {
          'content': postContentController.text,
          if (selectedImage != null)
            "image": await uploadFileToSupabaseStorage(file: selectedImage!),
          "shop_id": getIt<SupabaseClient>().auth.currentUser!.id,
          "created_at": DateTime.now().toIso8601String(),
        });
        emit(AddPostSuccess());
      } catch (e) {
        emit(AddPostFailure(error: e.toString()));
      }
    // }
  }

  void removeImage() {
    selectedImage = null;
    emit(AddPostImageRemoved());
  }
}
