import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/pick_image.dart';
import 'package:disan/core/network/supabase/auth/sign_up_with_password.dart';
import 'package:disan/core/network/supabase/database/add_data.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'shop_sign_up_state.dart';

class ShopSignUpCubit extends Cubit<ShopSignUpState> {
  ShopSignUpCubit() : super(ShopSignUpInitial());
  final formKey = GlobalKey<FormState>();
  //! controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final phoneController = TextEditingController();

  File? userImage;
  //! pickImage
  Future<void> pickUserImage() async {
    emit(PickImageLoading());
    pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        userImage = value;
        emit(PickImageSuccess());
      } else {
        emit(PickImageFailure(message: "Failed to pick image"));
      }
    });
  }

  //!
  List<CategoryModel> categories = [];
  getCategories() async {
    emit(GetCategoriesLoading());
    try {
      var categories =
          await getIt<SupabaseClient>().from("categories").select();
      this.categories =
          categories.map((e) => CategoryModel.fromJson(e)).toList();
      emit(GetCategoriesSuccess());
    } on Exception catch (e) {
      emit(GetCategoriesFailure(message: e.toString()));
    }
  }

  //! sign up function
  Future<void> shopSignUp() async {
    if (userImage == null) {
      emit(PickImageFailure(message: "Please pick an image"));
      return;
    }
    if (categoryController.text.isEmpty) {
      emit(PickImageFailure(message: "Please select a category"));
      return;
    }
    if (formKey.currentState!.validate()) {
      try {
        emit(ShopSignUpLoading());
        await signUpWithPassword(
            email: emailController.text, password: passwordController.text);
        await addData(tableName: "users", data: {
          "id": getIt<SupabaseClient>().auth.currentUser!.id,
          "role": getIt<CacheHelper>().getData(key: "role"),
          "full_name": userNameController.text,
          "email": emailController.text,
          "profile_picture": await uploadFileToSupabaseStorage(
            file: userImage!,
          ),
          "token": [await getIt<FirebaseMessaging>().getToken()]
        });
        await addData(tableName: "shops", data: {
          "id": getIt<SupabaseClient>().auth.currentUser!.id,
          "shop_name": userNameController.text,
          "address": addressController.text,
          "user_id": getIt<SupabaseClient>().auth.currentUser!.id,
          "description": descriptionController.text,
          "category_name": categoryController.text,
          "phone": phoneController.text,
          "category_id": categories
              .firstWhere((element) => element.name == categoryController.text)
              .id,
          "profile_picture": await uploadFileToSupabaseStorage(
            file: userImage!,
          ),
        });
        emit(ShopSignUpSuccess());
      } on Exception catch (e) {
        log(e.toString());
        emit(ShopSignUpFailure(message: e.toString()));
      }
    }
  }
}
