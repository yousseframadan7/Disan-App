import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitial()) {
    fetchProducts();
  }

  final supabase = getIt<SupabaseClient>();

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];

  String? searchQuery;
  double? minPrice;
  double? maxPrice;
  String? selectedCategory;

  // Pagination
  int pageSize = 10;
  int currentPage = 0;
  bool isFetchingMore = false;
  bool hasMoreData = true;

  /// تحميل المنتجات من Supabase
  Future<void> fetchProducts() async {
    try {
      emit(GetProductsLoading());

      final response = await supabase.from('products').select();

      products = response.map((e) => ProductModel.fromJson(e)).toList();
      log("Products loaded: ${products.length}");

      // Reset
      currentPage = 0;
      hasMoreData = true;
      filteredProducts.clear();

      // نطبق الفلاتر (لو فيه) على products
      final temp = _applyFiltersOnList(products);

      // نعمل Pagination لأول صفحة
      _loadInitialPage(temp);

      emit(GetProductsSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetProductsFailure(message: e.toString()));
    }
  }

  /// أول صفحة من Pagination
  void _loadInitialPage(List<ProductModel> source) {
    filteredProducts.clear();
    final end = pageSize > source.length ? source.length : pageSize;
    filteredProducts.addAll(source.sublist(0, end));
    currentPage = 1;
    hasMoreData = end < source.length;
  }

  /// Pagination (load more)
  Future<void> loadMore() async {
    if (!hasMoreData || isFetchingMore) return;
    isFetchingMore = true;

    debugPrint("🔄 Starting loadMore... currentPage=$currentPage");

    emit(LoadingMoreProducts());

    final start = currentPage * pageSize;
    final end = start + pageSize;

    final temp = _applyFiltersOnList(products);

    if (start >= temp.length) {
      hasMoreData = false;
      isFetchingMore = false;
      debugPrint("⚠️ No more data to load. Total items=${temp.length}");
      emit(GetProductsSuccess());
      return;
    }

    final newSlice = temp.sublist(start, end > temp.length ? temp.length : end);

    filteredProducts.addAll(newSlice);
    currentPage++;
    isFetchingMore = false;

    debugPrint(
        "✅ loadMore done. Loaded ${newSlice.length} items. Total now=${filteredProducts.length}");

    emit(GetProductsSuccess());
  }

  /// تطبيق الفلاتر
  List<ProductModel> _applyFiltersOnList(List<ProductModel> source) {
    var temp = List<ProductModel>.from(source);

    // Search
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      debugPrint("🔍 Filtering by search: $searchQuery");
      temp = temp.where((p) {
        return p.name.toLowerCase().contains(searchQuery!.toLowerCase().trim());
      }).toList();
    }

    // Min price
    if (minPrice != null) {
      temp = temp.where((p) => p.price >= minPrice!).toList();
    }

    // Max price
    if (maxPrice != null) {
      temp = temp.where((p) => p.price <= maxPrice!).toList();
    }

    // Category
    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      debugPrint("🔍 Filtering by category: $selectedCategory");
      temp = temp.where((p) {
        debugPrint("➡️ Product: ${p.name} | category=${p.category}");
        return p.category.toLowerCase().trim() ==
            selectedCategory!.toLowerCase().trim();
      }).toList();
    }

    return temp;
  }

  /// إعادة تطبيق الفلاتر + reset للـ pagination
  void applyFilters() {
    final temp = _applyFiltersOnList(products);
    _loadInitialPage(temp);

    if (filteredProducts.isEmpty) {
      emit(EmptyProducts());
    } else {
      emit(GetProductsSuccess());
    }
  }

  void searchProducts(String query) {
    searchQuery = query.trim();
    applyFilters();
  }

  void filterByPrice({double? min, double? max}) {
    minPrice = min;
    maxPrice = max;
    applyFilters();
  }

  void filterByCategory(String? category) {
    selectedCategory = category;
    applyFilters();
  }

  void resetFilters() {
    searchQuery = null;
    minPrice = null;
    maxPrice = null;
    selectedCategory = null;
    applyFilters();
  }
}
