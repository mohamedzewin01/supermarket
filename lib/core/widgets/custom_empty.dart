import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({
    super.key,
    required this.text,
    this.textButton,
    this.onTap,
    this.assetImage,
    this.activeButton = true,
  });

  final String text;
  final String? assetImage;
  final String? textButton;
  final VoidCallback? onTap;
  final bool? activeButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(assetImage ?? Assets.cartEmpty),
        ),
        AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: getSemiBoldStyle(
            color: ColorManager.primaryColor,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 20),
        activeButton ?? false
            ? ElevatedButton.icon(
              label: Text(
                textButton ?? '',
                style: getSemiBoldStyle(color: ColorManager.white),
              ),
              icon: Icon(Icons.arrow_back_ios, color: ColorManager.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: onTap,
            )
            : SizedBox(),
        SizedBox(height: kBottomNavigationBarHeight + 20),
      ],
    );
  }
}
