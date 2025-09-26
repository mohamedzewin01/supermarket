import 'package:flutter/material.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';

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

  void movedToNextPage() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RoutesManager.layout);
      }
    });
  }
}
