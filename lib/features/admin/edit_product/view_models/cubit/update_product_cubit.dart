import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/pick_image.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:disan/features/user/categories/models/sub_category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit({required this.product}) : super(UpdateProductInitial()) {
    getCategories();
    initControllers();
    getSubCategories();
  }
  final ProductModel product;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final categoryController = TextEditingController();
  File? image;
  //
  initControllers() {
    nameController.text = product.name;
    priceController.text = product.price.toString();
    descriptionController.text = product.description;
    quantityController.text = product.stock.toString();
    categoryController.text = product.category;
  }

  //
  updateProduct() async {
    // Validate form first
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      emit(UpdateProductFailure(message: "Please fill all fields correctly"));
      return;
    }

    bool hasChanges = image != null ||
        product.name != nameController.text ||
        product.price != double.tryParse(priceController.text) ||
        product.description != descriptionController.text ||
        product.stock != int.tryParse(quantityController.text) ||
        product.category != categoryController.text ;

    if (!hasChanges) {
      emit(UpdateProductFailure(message: "No changes detected"));
      return;
    }

    try {
      emit(UpdateProductLoading());
      final updatedData = {
        "name": nameController.text,
        "price": double.tryParse(priceController.text) ?? 0.0,
        "description": descriptionController.text,
        "stock": int.tryParse(quantityController.text) ?? 0,
        "category": categoryController.text,
        "category_id": categories
            .firstWhere((element) => element.name == categoryController.text)
            .id,
        "image_url": image != null
            ? await uploadFileToSupabaseStorage(file: image!)
            : product.image,
      
      };
      await getIt<SupabaseClient>()
          .from("products")
          .update(updatedData)
          .match({"id": product.id});
      image = null;
      emit(UpdateProductSuccess());
    } on FormatException {
      emit(UpdateProductFailure(message: "Invalid input format"));
    } on Exception catch (e) {
      emit(UpdateProductFailure(message: "Database error: $e"));
    } catch (e) {
      emit(UpdateProductFailure(message: "An unexpected error occurred"));
    }
  }

  //
  List<CategoryModel> categories = [];
  getCategories() async {
    try {
      emit(GetCategoriesLoading());
      final response =
          await getIt<SupabaseClient>().from("categories").select();
      categories = response
          .map<CategoryModel>((e) => CategoryModel.fromJson(e))
          .toList();
      emit(GetCategoriesSuccess());
    } on Exception catch (e) {
      emit(GetCategoriesFailure(message: e.toString()));
    }
  }

  //
  List<SubCategoryModel> subCategories = [];
  getSubCategories() async {
    try {
      emit(GetSubCategoriesLoading());
      final response =
          await getIt<SupabaseClient>().from("sub_categories").select();
      subCategories = response
          .map<SubCategoryModel>((e) => SubCategoryModel.fromJson(e))
          .toList();
      filtereSubCategories = subCategories
          .where((element) => element.categoryId == product.categoryId)
          .toList();
      emit(GetSubCategoriesSuccess());
    } on Exception catch (e) {
      emit(GetSubCategoriesFailure(message: e.toString()));
    }
  }

  //
  List<SubCategoryModel> filtereSubCategories = [];
  filterSubCategories(String categoryName) {
    final id =
        categories.firstWhere((element) => element.name == categoryName).id;
    filtereSubCategories =
        subCategories.where((element) => element.categoryId == id).toList();
    emit(GetSubCategoriesSuccess());
  }

  //
  pickProductImage() async {
    try {
      emit(PickImageLoading());
      pickImage(source: ImageSource.gallery).then((value) {
        if (value != null) {
          image = value;
          emit(UpdateProductSuccess());
        }
      });
      emit(UpdateProductSuccess());
    } on Exception catch (e) {
      emit(PickImageFailure(message: e.toString()));
    }
  }
}
