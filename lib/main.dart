import 'package:device_preview/device_preview.dart';
import 'package:disan/app/my_app.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:disan/core/helper/date_picker.dart';
import 'package:disan/core/notifications/fcm_notification.dart';
import 'package:disan/firebase_options.dart';
import 'package:disan/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> clearOldCacheIfNeeded() async {
  final prefs = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.buildNumber;

  final savedVersion = prefs.getString('last_version');

  if (savedVersion != currentVersion) {
    // التطبيق تم تحديثه
    await DefaultCacheManager().emptyCache(); // مسح الكاش
    await prefs.setString(
        'last_version', currentVersion); // تحديث النسخة المخزنة
    debugPrint("✅ Old cache cleared due to app update.");
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: "https://rhrpfgeerupvmqgucrda.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJocnBmZ2VlcnVwdm1xZ3VjcmRhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkwMjI2OTgsImV4cCI6MjA2NDU5ODY5OH0.HyqgYFw5pJNhd0Wjyky_ZkQScQsoho_3Mhmvgt-RypY",
  );
  await setupDI();
  await clearOldCacheIfNeeded();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await getIt<NotificationsHelper>().initNotifications();
  getIt<NotificationsHelper>().setupFirebaseMessaging();

  DateHelper.initialize();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: DevicePreview(
        enabled: false,
        builder: (context) => MyApp(),
      ),
    ),
  );
}
