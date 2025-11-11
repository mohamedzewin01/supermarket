import 'package:manarat_amjad/features/best_deals/presention/pages/best_deals_view.dart';
import 'package:manarat_amjad/features/cart/presentation/pages/cart_view.dart';
import 'package:manarat_amjad/features/profile/presentation/pages/profile.dart';
import 'package:manarat_amjad/features/search/presentation/pages/search_view.dart';
import 'package:flutter/material.dart';


import '../../features/categories/presentation/pages/categories.dart';
import '../../features/home/presentation/pages/home_view.dart';


class AppConstants {
  static const int listGenerate = 6;

  static const String version = 'v1.0.15';
  static const String collection = 'OrdersInfo';
  static const String copyright = '© 2025 MNRRA • جميع الحقوق محفوظة';
  static const viewOptions = [
    HomeView(),
    // BestDealsView(),
    Categories(),
    CartView(),
    SearchPage(),
    Profile(),
  ];
}

