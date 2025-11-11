import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/core/utils/remote_config.dart';
import 'package:manarat_amjad/core/widgets/app_closed_page.dart';
import 'package:manarat_amjad/features/layout/presentation/pages/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';

import 'core/resources/assets_manager.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/style_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    movedToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor,
      body: Stack(
        children: [

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset(
                  Assets.logo3,
                  scale: 2.5,
                ),
                SizedBox(height: 16,),
                CircularProgressIndicator(color: ColorManager.white,),
                SizedBox(height: 16,),
                Spacer(),
                Text(
                  '© جميع الحقوق محفوظة لتموينات منارة أمجاد والعلامة التجارية الخاصة بها',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),

        ],
      ),
    );
  }
  Future<void> movedToNextPage() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    final isAppEnabled = await ForceUpdateChecker().fetchAppEnabledStatus();


    Widget nextScreen;
    if (!isAppEnabled) {
      nextScreen = const AppClosedPage();
    } else  {
      nextScreen = const LayoutScreen();
    }

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }
  // void movedToNextPage() {
  //   Future.delayed(const Duration(seconds: 4), () {
  //     isAppEnabled ? const LayoutScreen() : const AppClosedPage();
  //     if (mounted) {
  //       Navigator.pushReplacementNamed(context, RoutesManager.layout);
  //     }
  //   });
  // }
}
