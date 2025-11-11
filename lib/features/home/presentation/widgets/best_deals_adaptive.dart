import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/adaptive layout.dart';
import 'all_best_deals.dart';

class BestDealsAdaptive extends StatelessWidget {
  const BestDealsAdaptive({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const AllBestDealsView(),
      tabletLayout: (context) => const AllBestDealsView(),
      desktopLayout: (context) =>  Center(child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Scaffold(
                backgroundColor: ColorManager.primaryColor,
                body: Center(
                  child: Image.asset(
                    Assets.logo,
                    scale: 2.5,
                  ),
                ),
              )),
          Expanded(flex: 2, child: AllBestDealsView()),
          Expanded(
              flex: 3,
              child: Scaffold(
                backgroundColor: ColorManager.primaryColor,
                body: Center(
                  child: Image.asset(
                    Assets.logo,
                    scale: 2.5,
                  ),
                ),
              )),
        ],
      )),
    );
  }
}
