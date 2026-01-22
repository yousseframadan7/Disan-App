import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/pick_image.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial()) {
    initUserProfile();
  }

  var userModel = getIt<CacheHelper>().getUserModel();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  File? image;
  bool updateEmail = false;
  final supabase = getIt<SupabaseClient>();
  initUserProfile() async {
    nameController.text = userModel!.name;
    emailController.text = userModel!.email;
    phoneController.text = userModel!.phone;
  }

  pickProfileImage() async {
    emit(PickImageLoading());
    pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = value;
        emit(PickImageScucess());
      } else {
        emit(PickImageFailure(
          message: "No image selected",
        ));
      }
    });
  }

  updateProfile() async {
    try {
      if (nameController.text != userModel!.name ||
          emailController.text != userModel!.email ||
          image != null ||
          phoneController.text != userModel!.phone) {
        emit(UpdateProfileLoading());
        if (emailController.text != userModel!.email) {
          final response = await supabase.auth.updateUser(
            UserAttributes(email: emailController.text),
          );
          updateEmail = true;
          if (response.user == null) {
            throw Exception('Failed to update email in Supabase Auth');
          }
        }

        await supabase.from("users").update({
          "full_name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "profile_picture": image != null
              ? await uploadFileToSupabaseStorage(file: image!)
              : userModel!.image
        }).eq("id", userModel!.id);

        final response = await supabase
            .from("users")
            .select()
            .eq("id", userModel!.id)
            .single();

        userModel = UserModel.fromJson(response);
        await getIt<CacheHelper>().saveUserModel(userModel!);
        initUserProfile();
        if (updateEmail) {
          emit(UpdateProfileEmail());
        }
        updateEmail = false;
        image = null;
        emit(UpdateProfileSuccess());
      } else {
        emit(NoChangeProfile());
      }
    } on Exception catch (e) {
      emit(UpdateProfileFailure(message: e.toString()));
    }
  }
}
