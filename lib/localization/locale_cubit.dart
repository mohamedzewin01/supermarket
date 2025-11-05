import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/cashed_data_shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar')) {
    _loadSavedLanguage();
  }



  void changeLanguage(String languageCode) async {
    emit(Locale(languageCode));
    await CacheService.setData(
        key: CacheKeys.defaultLanguage, value: languageCode);
  }

  String changeFontFamily() {
    return state.languageCode == 'ar' ? 'NotoSansArabic' : 'Roboto';
  }

  void _loadSavedLanguage() {
    final savedLanguage =
        CacheService.getData(key: CacheKeys.defaultLanguage) ?? 'ar';
    emit(Locale(savedLanguage));
  }
}
