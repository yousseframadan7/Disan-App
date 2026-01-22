import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/pick_image.dart';
import 'package:disan/core/network/supabase/storage/upload_file.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  AddOfferCubit() : super(GetProductsLoading()) {
    getProducts();
  }
  List<ProductModel> products = [];
  final supabase = getIt<SupabaseClient>();
  File? offerImage;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountController = TextEditingController();
  final buyController = TextEditingController();
  final getController = TextEditingController();
  final offerTypeController = TextEditingController();
  final endDateController = TextEditingController();
  ProductModel? selectedProduct;
  ProductModel? selectedProductForOffer;
  DateTime? selectedEndDate; // متغير جديد لتخزين التاريخ المختار

  // get Products
  getProducts() async {
    try {
      final response = await supabase
          .from('products')
          .select()
          .eq('shop_id', getIt<SupabaseClient>().auth.currentUser!.id);
      if (response.isEmpty) {
        emit(EmptyProducts());
      } else {
        products = response.map((e) => ProductModel.fromJson(e)).toList();
        emit(GetProductsSuccess());
      }
    } on Exception catch (e) {
      emit(GetProductsFailure(e.toString()));
    }
  }

  // pick image

  pickOfferImage() async {
    try {
      final value = await pickImage(source: ImageSource.gallery);
      if (value != null) {
        offerImage = File(value.path);
        emit(PickImageSuccess());
      } else {
        emit(PickImageFailure("No image selected"));
      }
    } catch (e) {
      emit(PickImageFailure(e.toString()));
    }
  }

  // add offer
  addOffer() async {
    if (titleController.text.isEmpty || selectedProduct == null) {
      emit(FieldEmpty(
          message:
              "Please fill all fields correctly { title , offer type , product }"));
      return;
    }
    var offerType = getIt<CacheHelper>().getData(key: "offerType");
    if (offerType == "discount" && discountController.text.isEmpty) {
      emit(FieldEmpty(message: "Please fill discount field"));
      return;
    }
    if (offerType == "buyXgetYSame" &&
        buyController.text.isEmpty &&
        getController.text.isEmpty) {
      emit(FieldEmpty(message: "Please fill buy and get fields"));
      return;
    }
    if (offerType == "buyXgetYSame" &&
        buyController.text.isEmpty &&
        getController.text.isEmpty &&
        selectedProductForOffer == null) {
      emit(FieldEmpty(
          message:
              "Please fill buy and get fields and select a product for the offer"));
      return;
    }
    if (offerType == "gift" && selectedProductForOffer == null) {
      emit(FieldEmpty(message: "Please select a product for the offer"));
      return;
    }
    if (selectedEndDate == null) {
      emit(FieldEmpty(message: "Please select an end date for the offer"));
      return;
    }
    try {
      emit(AddOfferLoading());
      await supabase.from('offers').insert({
        'title': titleController.text,
        'description': descriptionController.text,
        'product_id': selectedProduct?.id,
        'shop_id': getIt<SupabaseClient>().auth.currentUser!.id,
        "discount_percent": discountController.text.isEmpty
            ? null
            : int.parse(discountController.text),
        "offer_type": offerType,
        'buy_quantity':
            buyController.text.isEmpty ? null : int.parse(buyController.text),
        'get_quantity':
            getController.text.isEmpty ? null : int.parse(getController.text),
        "image_url": offerImage != null
            ? await uploadFileToSupabaseStorage(file: offerImage!)
            : null,
        "end_date": selectedEndDate!.toIso8601String(),
      });
      emit(AddOfferSuccess());
    } on Exception catch (e) {
      log("Error adding offer: ${e.toString()}");
      emit(AddOfferFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    discountController.dispose();
    buyController.dispose();
    getController.dispose();
    offerTypeController.dispose();
    endDateController.dispose();
    return super.close();
  }
}
