import 'package:disan/app/cubit/localization_cubit.dart';
import 'package:disan/core/cache/cache_helper.dart';
import 'package:disan/core/helper/translation_services.dart';
import 'package:disan/core/notifications/fcm_notification.dart';
import 'package:disan/core/notifications/local_notifications_services.dart';
import 'package:disan/features/user/wishlist/view_models/cubit/wish_list_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
// import 'package:disan/features/user/home/view_models/cubit/get_categories_cubit.dart';
// import 'package:disan/features/user/home/view_models/cubit/get_products_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  getIt.registerSingleton<CacheHelper>(cacheHelper);
  getIt.registerLazySingleton(() => Supabase.instance.client);
  getIt.registerLazySingleton(() => NotificationsHelper());
  getIt.registerLazySingleton(() => FirebaseMessaging.instance);
  getIt.registerLazySingleton(() => LocalNotificationsServices());
  getIt.registerLazySingleton(() => TranslationService());
  getIt.registerLazySingleton<WishListCubit>(() => WishListCubit());
  getIt.registerLazySingleton<TranslationCubit>(() => TranslationCubit());
}
