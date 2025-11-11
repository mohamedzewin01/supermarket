// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:manarat_amjad/core/resources/assets_manager.dart';
// import 'package:manarat_amjad/core/resources/color_manager.dart';
// import 'package:manarat_amjad/core/resources/routes_manager.dart';
// import 'package:manarat_amjad/core/resources/style_manager.dart';
// import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
// import 'package:flutter/material.dart';
//
// // void showAuthActionSheet(BuildContext context) {
// //   showModalBottomSheet(
// //     context: context,
// //     shape: const RoundedRectangleBorder(
// //       borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
// //     ),
// //     backgroundColor: Colors.white,
// //     builder: (context) {
// //       return Stack(
// //         clipBehavior: Clip.none,
// //         children: [
// //           Positioned(
// //             top: -25,
// //             right: 20,
// //             child: GestureDetector(
// //               onTap: () {
// //                 Navigator.pop(context); // إغلاق الـ Bottom Sheet
// //               },
// //               child: Container(
// //                 width: 45,
// //                 height: 45,
// //                 alignment: Alignment.center,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   color: ColorManager.white, // اللون الخارجي
// //                 ),
// //                 child: Container(
// //                   width: 40,
// //                   height: 40,
// //                   padding: EdgeInsets.all(6),
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: ColorManager.primaryColor, // اللون الداخلي
// //                   ),
// //                   child: Image.asset(Assets.logo3),
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Center(
// //                   child: AutoSizeText(
// //                     "تسجيل دخول",
// //                     style: getSemiBoldStyle(
// //                       color: ColorManager.blueDark,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 24),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: CustomElevatedButton(
// //                         buttonColor: ColorManager.primaryColor,
// //                         title: "تأكيد",
// //                         onPressed: () {
// //                           Navigator.pop(context,true);
// //                           Navigator.pushNamed(context, RoutesManager.authScreen);
// //                         },
// //                       ),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     Expanded(
// //                       child: CustomElevatedButton(
// //                         buttonColor: ColorManager.error,
// //                         title: "إلغاء",
// //                         onPressed: () {
// //                           Navigator.pop(context, false); // إغلاق الـ Bottom Sheet
// //                         },
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 8),
// //               ],
// //             ),
// //           ),
// //         ],
// //       );
// //
// //     },
// //   );
// // }
// void showAuthActionSheet(BuildContext context, {VoidCallback? onLoginSuccess}) {
//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
//     ),
//     backgroundColor: Colors.white,
//     builder: (context) {
//       return Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // زر الإغلاق ...
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16.0,
//               vertical: 24.0,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(child: Text("تسجيل دخول")),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomElevatedButton(
//                         title: "تأكيد",
//                         onPressed: () async {
//                           // Navigator.pop(context); // أغلق الـ BottomSheet
//                           final result =await  Navigator.pushNamed(
//                             context,
//                             RoutesManager.authScreen,
//                           );
//
//                           if (result == true && onLoginSuccess != null) {
//                             onLoginSuccess();
//                           }
//                         },
//                         buttonColor: ColorManager.primaryColor,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomElevatedButton(
//                         title: "إلغاء",
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         buttonColor: ColorManager.error,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
