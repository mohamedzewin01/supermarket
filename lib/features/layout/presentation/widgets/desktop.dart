import 'package:manarat_amjad/features/app_search/presentation/bloc/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:manarat_amjad/features/layout/presentation/widgets/mobile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Scaffold(
              backgroundColor: ColorManager.primaryColor,
              body: Center(
                child: Image.asset(
                  Assets.logo3,
                  scale: 2.5,
                ),
              ),
            )),
        Expanded(flex: 2, child: LayoutMobileView()),
        Expanded(
            flex: 1,
            child: Scaffold(

              backgroundColor: ColorManager.primaryColor,
              body: Center(
                child: Image.asset(
                  Assets.logo3,
                  scale: 2.5,
                ),
              ),
            )),
      ],
    );
  }
}
