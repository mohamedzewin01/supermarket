
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeProfile extends StatelessWidget {
  const SkeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.person,
              size: 100,
              color: ColorManager.primaryColor,
            ),
          ),
          Text(
            '1234555556',
            style: getSemiBoldStyle(
              color: ColorManager.secondaryColor,
              fontSize: 16,
            ),
          ),

          Text(
            '12345555555555555555556',
            style: getSemiBoldStyle(
              color: ColorManager.secondaryColor,
              fontSize: 16,
            ),
            textDirection: TextDirection.ltr,
          ),
          Text(
            '123455555555556',
            style: getSemiBoldStyle(
              color: ColorManager.placeHolderColor2,
              fontSize: 14,
            ),
            textDirection: TextDirection.ltr,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
