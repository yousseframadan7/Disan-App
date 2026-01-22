import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationCubit extends Cubit<Locale> {
  TranslationCubit() : super(const Locale('en')); // default

  static const String _langKey = 'selected_language';

  Future<void> loadSavedLanguage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    final savedLang = prefs.getString(_langKey);
    Locale newLocale;
    if (savedLang != null) {
      newLocale = Locale(savedLang);
    } else {
      final deviceLocale = context.deviceLocale.languageCode;
      newLocale = Locale(deviceLocale);
    }
    await context.setLocale(newLocale);
    emit(newLocale);
  }

  /// تغيير اللغة وتخزينها
  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    final newLocale = Locale(languageCode);

    await prefs.setString(_langKey, languageCode);
    await context.setLocale(newLocale);
    emit(newLocale);
  }
}
