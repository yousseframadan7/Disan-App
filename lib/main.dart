import 'package:device_preview/device_preview.dart';
import 'package:disan/app/my_app.dart';
import 'package:disan/core/di/dependancy_injection.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://sgrovovedthbbxbvsqzp.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNncm92b3ZlZHRoYmJ4YnZzcXpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgwNzc2NDksImV4cCI6MjA2MzY1MzY0OX0.4X-p3CARcgztoY1x8MRlATzpyypbspOU6W927Rlg7WM",
  );
  setupDI();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}



