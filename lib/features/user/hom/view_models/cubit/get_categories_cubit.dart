import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/network/supabase/database/get_stream_data.dart';
import 'package:disan/features/user/categories/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(GetCategoriesInitial()) {
    getCategory();
  }

  StreamSubscription? categorySubscription;
  List<CategoryModel> categories = [];

  int retryCount = 0;
  final int maxRetries = 3;


  void getCategory() {
    emit(GetCategoriesLoading());

    try {
      categorySubscription = streamData(tableName: "categories").listen(
        (event) {
          if (event.isNotEmpty) {
            categories = event.map((e) => CategoryModel.fromJson(e)).toList();
            emit(GetCategoriesSuccess());
          } else {
            emit(EmptyCategories());
          }
        },
        onError: (error) async {
          if (retryCount < maxRetries) {
            retryCount++;
            emit(GetCategoriesLoading());
            await Future.delayed(const Duration(seconds: 1));
            getCategory();
          } else {
            emit(GetCategoriesFailure(message: error.toString()));
          }
        },
      );
    } on Exception catch (e) {
      emit(GetCategoriesFailure(message: e.toString()));
    }
  }
  deleteCategory({required String id}) async {
    try {
      emit(DeleteCategoryLoading());
      await getIt<SupabaseClient>().from('categories').delete().eq('id', id);
      emit(DeleteCategorySuccess());
    } on Exception catch (e) {
      emit(DeleteCategoryFailure(message: e.toString()));
    }
  }
  @override
  Future<void> close() {
    categorySubscription?.cancel();
    return super.close();
  }
}

