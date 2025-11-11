
import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

import '../api/api_constants.dart';

// class CategoriesView extends StatelessWidget {
//   const CategoriesView({
//     super.key,
//     required this.imagePath,
//     required this.catName,
//   });
//
//   final String imagePath;
//   final String catName;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: Colors.pink,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//
//
//           Card(
//             elevation: 6,
//             clipBehavior: Clip.antiAlias,
//
//             child: Padding(
//               padding: const EdgeInsets.all(2.0),
//               child: CustomImage(url: imagePath,height: 50,width: 50,),
//             ),
//           ),
//
//           SizedBox(height: 4),
//           Center(
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: AutoSizeText(
//                 catName,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//                 style: getSemiBoldStyle(color: ColorManager.black, fontSize: 12),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
    required this.imagePath,
    required this.catName,
  });

  final String imagePath;
  final String catName;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 6.0,
          shape: const CircleBorder(),
          shadowColor: Colors.black45,
          child: CircleAvatar(
            backgroundColor: ColorManager.primary3.withOpacity(.6),
            radius: 35,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImage(url: imagePath),
            ),
          ),
        ),


        SizedBox(
          height: 4,
        ),
        Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: AutoSizeText(
              catName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: getSemiBoldStyle(color: ColorManager.black, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}