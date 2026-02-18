import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/pick_image.dart';
import 'package:disan/core/network/supabase/database/add_data.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(GetCategoriesLoading()) {
    getCategories();
  }
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final stockController = TextEditingController();

  File? productImage;
  //! pick image
  pickProductImage() async {
    emit(PickImageLoading());
    final image = await pickImage(source: ImageSource.gallery);
    if (image != null) {
      productImage = image;
      emit(PickImageSuccess());
    }
  }

  Future<void> addProduct() async {
    try {
      if (productImage == null) {
        emit(AddProductFailure(message: "Please pick an image"));
        return;
      }
      if (formKey.currentState!.validate()) {
        emit(AddProductLoading());
        log(getIt<SupabaseClient>().auth.currentUser!.id);
        await addData(
          tableName: "products",
          data: {
            "shop_id": getIt<SupabaseClient>().auth.currentUser!.id,
            "name": nameController.text,
            "price": priceController.text,
            "description": descriptionController.text,
            "category": categoryController.text,
            "image_url": await uploadFileToSupabaseStorage(file: productImage!),
            "stock": stockController.text,
            "category_id": categories
                .firstWhere(
                  (element) => element.name == categoryController.text,
                )
                .id
                .toString(),
            "shop_name": getIt<CacheHelper>().getUserModel()!.name,
          },
        );
        emit(AddProductSuccess());
      }
    } on Exception catch (e) {
      emit(AddProductFailure(message: e.toString()));
    }
  }

  //!
  List<CategoryModel> categories = [];
  getCategories() async {
    final response = await getIt<SupabaseClient>().from("categories").select();
    categories = response.map((e) => CategoryModel.fromJson(e)).toList();
    emit(AddProductInitial());
  }
}
