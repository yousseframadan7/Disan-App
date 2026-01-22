import 'dart:convert';
import 'package:disan/features/user/cart/models/cart_model.dart';
import 'package:disan/features/user/shop_products/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:disan/features/admin/time_lines/story/models/user_model.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  //! Initialize the cache
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //! Save basic types
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else {
      throw Exception('Unsupported type');
    }
  }

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  //! Save UserModel in local storage
  Future<bool> saveUserModel(UserModel user) async {
    String userJson = jsonEncode(user.toJson());
    return await sharedPreferences.setString('user', userJson);
  }

  //! Get UserModel from local storage
  UserModel? getUserModel() {
    String? userJson = sharedPreferences.getString('user');
    if (userJson == null) return null;

    Map<String, dynamic> userMap = jsonDecode(userJson);
    return UserModel.fromJson(userMap);
  }

  //! Add favorite ID
  Future<void> addFavorite(String id) async {
    final List<String> favorites = getFavoriteIds();
    if (!favorites.contains(id)) {
      favorites.add(id);
      await sharedPreferences.setStringList('favorites', favorites);
    }
  }

  //! Remove favorite ID
  Future<void> removeFavorite(String id) async {
    final List<String> favorites = getFavoriteIds();
    favorites.remove(id);
    await sharedPreferences.setStringList('favorites', favorites);
  }

  //! Check if item is favorite
  bool isFavorite(String id) {
    final List<String> favorites = getFavoriteIds();
    return favorites.contains(id);
  }

  //! Get all favorite IDs
  List<String> getFavoriteIds() {
    return sharedPreferences.getStringList('favorites') ?? [];
  }

  //! Toggle favorite (helper function)
  Future<void> toggleFavorite(String id) async {
    if (isFavorite(id)) {
      await removeFavorite(id);
    } else {
      await addFavorite(id);
    }
  }

  //! Add item to cart or update quantity
  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    final List<String> cartJsonList =
        sharedPreferences.getStringList('cart') ?? [];

    List<CartItemModel> cartItems =
        cartJsonList.map((e) => CartItemModel.fromJson(jsonDecode(e))).toList();

    final index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      // المنتج موجود، زود الكمية
      cartItems[index].quantity += quantity;
    } else {
      // المنتج مش موجود، ضيفه
      cartItems.add(CartItemModel(product: product, quantity: quantity));
    }

    // احفظ البيانات الجديدة
    final updatedJsonList =
        cartItems.map((e) => jsonEncode(e.toJson())).toList();
    await sharedPreferences.setStringList('cart', updatedJsonList);
  }

//! Remove item from cart
  Future<void> removeFromCart(String id) async {
    final List<CartItemModel> cartItems = getCartItems();
    cartItems.removeWhere((item) => item.product.id == id);
    final updatedJsonList =
        cartItems.map((e) => jsonEncode(e.toJson())).toList();
    await sharedPreferences.setStringList('cart', updatedJsonList);
  }

//! Get all cart items
  List<CartItemModel> getCartItems() {
    final List<String> cartJsonList =
        sharedPreferences.getStringList('cart') ?? [];

    return cartJsonList
        .where((e) {
          try {
            final json = jsonDecode(e);
            return json is Map<String, dynamic>;
          } catch (_) {
            return false;
          }
        })
        .map((e) => CartItemModel.fromJson(jsonDecode(e)))
        .toList();
  }

//! Check if item is in cart
  bool isInCart(String id) {
    final List<CartItemModel> cartItems = getCartItems();
    return cartItems.any((item) => item.product.id == id);
  }

//! Toggle cart item
  Future<void> toggleCartItem(ProductModel product) async {
    if (isInCart(product.id)) {
      await removeFromCart(product.id);
    } else {
      await addToCart(product);
    }
  }

//! Update quantity
  Future<void> updateQuantity(String id, int newQuantity) async {
    final List<CartItemModel> cartItems = getCartItems();
    final index = cartItems.indexWhere((item) => item.product.id == id);
    if (index != -1) {
      cartItems[index].quantity = newQuantity;
      final updatedJsonList =
          cartItems.map((e) => jsonEncode(e.toJson())).toList();
      await sharedPreferences.setStringList('cart', updatedJsonList);
    }
  }

  //! Clear cart
  Future<void> clearCart() async {
    await sharedPreferences.remove('cart');
  }
}
