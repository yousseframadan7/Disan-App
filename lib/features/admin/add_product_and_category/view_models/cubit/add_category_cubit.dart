import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:disan/core/helper/pick_image.dart';
import 'package:disan/core/network/supabase/database/add_data.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryInitial());
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  File? categoryImage;
  //! pick image
  pickCategoryImage() async {
    emit(PickImageLoading());
    final image = await pickImage(source: ImageSource.gallery);
    if (image != null) {
      categoryImage = image;
      emit(PickImageSuccess());
    }
  }

  Future<void> addCategory() async {
    try {
      if (categoryImage == null) {
        emit(AddCategoryFailure(
          message: "Please pick an image",
        ));
        return;
      }
      if (formKey.currentState!.validate()) {
        emit(AddCategoryLoading());
        addData(tableName: "categories", data: {
          "name": nameController.text,
          "description": descriptionController.text,
          "image_url": await uploadFileToSupabaseStorage(file: categoryImage!),
        });
        emit(AddCategorySuccess());
      }
    } on Exception catch (e) {
      emit(AddCategoryFailure(message: e.toString()));
    }
  }
}
