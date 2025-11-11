import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error,size: 30,color: ColorManager.red,),
        Text('حدث خطاء',style: getSemiBoldStyle(color: ColorManager.red,fontSize: 20),),
      ],
    ));
  }
}