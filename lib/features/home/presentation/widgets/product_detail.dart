// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:manarat_amjad/core/resources/cashed_image.dart';
// import 'package:manarat_amjad/core/resources/color_manager.dart';
// import '../../../../core/resources/assets_manager.dart';
// import '../../../../views/common_widgets/appBar.dart';
// import '../../data/models/response/home_model_response_dto.dart';
//
// class ProductDetailScreen extends StatelessWidget {
//   const ProductDetailScreen({super.key, required this.product});
//
//
//   final ProductsBestDeals? product;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(
//         title: Text(product?.productName ?? ''),
//         leading: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//           child: InkWell(
//               customBorder:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: SvgPicture.asset(Assets.imagesBack)),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 2,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                         border: Border(
//                             bottom: BorderSide(
//                                 width: 4, color: ColorManager.primaryColor),
//                             left: BorderSide(
//                                 width: .5, color: ColorManager.primaryColor),
//                             right: BorderSide(
//                                 width: .5, color: ColorManager.primaryColor)),
//                         borderRadius: BorderRadius.vertical(
//                             bottom: Radius.elliptical(
//                                 MediaQuery.of(context).size.width, 140.0))),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       child: Hero(
//                         tag: product?.idProduct??'',
//                         child: CustomImage(
//                           url: product?.imageCover ?? '',
//                           width: 140,
//                           height: 180,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "${product?.productPriceAfterDiscount ?? 0.00} SAR",
//                           style: TextStyle(
//                             color: Color(0xffFF324B),
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 14,
//                         ),
//                         Text(
//                           product?.productName ?? "????",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.normal,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 14,
//                         ),
//                         // Text(
//                         //   "Quantity : ${product.}",
//                         //   style: TextStyle(
//                         //     color: Get.theme.primaryColor,
//                         //     fontSize: 14,
//                         //     fontWeight: FontWeight.bold,
//                         //   ),
//                         // ),
//                         SizedBox(
//                           height: 14,
//                         ),
//                         Text(
//                           "tags: ${product?.categoryName ?? ''}",
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.normal),
//                         ),
//                         SizedBox(
//                           height: 32,
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//
//           Expanded(
//             flex: 0,
//             child: Container(
//               padding: const EdgeInsets.all(16.0),
//               color: Get.theme.cardColor.withAlpha(100),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         children: [
//                           Text("Total price (with tax)",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               )),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Text("${product?.productPriceAfterDiscount ?? 10.00}",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.bold))
//                         ],
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
// }
