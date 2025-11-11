import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/adaptive layout.dart';
import '../../../analytics/analytics_helper.dart';
import '../../../app_search/presentation/bloc/search_cubit.dart';
import '../cubit/layout_cubit.dart';
import '../widgets/desktop.dart';
import '../widgets/mobile.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        // BlocProvider.value(value: GetIt.instance<CartCubit>()),
      ],

      child: AdaptiveLayout(
        mobileLayout: (context) => const LayoutMobileView(),
        tabletLayout: (context) => const DesktopLayout(),
        desktopLayout: (context) => const Center(child: DesktopLayout()),
      ),
    );
  }
}
