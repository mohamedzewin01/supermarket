import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fada_alhalij_web/core/api/api_constants.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:fada_alhalij_web/core/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/response/home_model_response_dto.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key, required this.banners});

  final List<Banners> banners;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders =
    banners
        .map(
          (items) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 48,
                decoration: BoxDecoration(
                    color:ColorManager.primaryColor
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            bottomLeft: Radius.circular(18),
                          ),
                          color: Colors.grey.withAlpha(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${ApiConstants.baseUrlImage}${items.bannersUrlImage}',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Text(
                            items.bannersTitle ?? '',
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily:
                              GoogleFonts.cairo(
                                fontWeight: FontWeight.w900,
                              ).fontFamily,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Text(
                            items.bannersDescription ?? '',
                            maxLines: 1,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily:
                              GoogleFonts.cairo(
                                fontWeight: FontWeight.w900,
                              ).fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    )
        .toList().reversed.toList();

    return RepaintBoundary(
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.9,
          aspectRatio: 4,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
        ),
        items: imageSliders,
      ),
    );
  }
}

//
// import 'dart:math';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:fada_alhalij_web/core/api/api_constants.dart';
// import 'package:fada_alhalij_web/core/resources/cashed_image.dart';
// import 'package:fada_alhalij_web/core/resources/color_manager.dart';
// import 'package:fada_alhalij_web/core/resources/style_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../data/models/response/home_model_response_dto.dart';
//
// class Carousel extends StatefulWidget {
//   const Carousel({super.key, required this.banners});
//
//   final List<Banners> banners;
//
//   @override
//   State<Carousel> createState() => _CarouselState();
// }
//
// class _CarouselState extends State<Carousel> {
//   int _currentIndex = 0;
//   final CarouselSliderController _carouselController = CarouselSliderController();
//
//   // قائمة ألوان عصرية ومتناسقة
//   final List<List<Color>> gradientColors = [
//     [Color(0xFFFF6B6B), Color(0xFFEE5A6F)], // أحمر وردي
//     [Color(0xFF4ECDC4), Color(0xFF44A08D)], // فيروزي أخضر
//     [Color(0xFFFFBE76), Color(0xFFF77062)], // برتقالي وردي
//     [Color(0xFF667EEA), Color(0xFF764BA2)], // بنفسجي
//     [Color(0xFFF093FB), Color(0xFFF5576C)], // زهري
//     [Color(0xFF4FACFE), Color(0xFF00F2FE)], // أزرق سماوي
//     [Color(0xFFFA709A), Color(0xFFFEE140)], // وردي أصفر
//     [Color(0xFF30CFD0), Color(0xFF330867)], // فيروزي بنفسجي
//   ];
//
//   final List<IconData> actionIcons = [
//     Icons.local_fire_department_rounded,
//     Icons.celebration_rounded,
//     Icons.card_giftcard_rounded,
//     Icons.percent_rounded,
//     Icons.auto_awesome_rounded,
//     Icons.flash_on_rounded,
//     Icons.rocket_launch_rounded,
//     Icons.star_rounded,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final Random random = Random();
//
//     final List<Widget> imageSliders = widget.banners
//         .asMap()
//         .entries
//         .map((entry) {
//       final index = entry.key;
//       final banner = entry.value;
//       final colorPair = gradientColors[index % gradientColors.length];
//
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Stack(
//               children: [
//                 // الخلفية المتدرجة
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         colorPair[0],
//                         colorPair[1],
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // تأثير الإضاءة
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: RadialGradient(
//                         center: Alignment.topRight,
//                         radius: 1.5,
//                         colors: [
//                           Colors.white.withOpacity(0.2),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // المحتوى
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Row(
//                     children: [
//                       // الجانب الأيسر - النص
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // الأيقونة
//                             Container(
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.25),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Icon(
//                                 actionIcons[index % actionIcons.length],
//                                 color: Colors.white,
//                                 size: 28,
//                               ),
//                             ),
//
//                             const SizedBox(height: 16),
//
//                             // العنوان
//                             Text(
//                               banner.bannersTitle ?? 'عرض مميز',
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.cairo(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 height: 1.3,
//                                 shadows: [
//                                   Shadow(
//                                     color: Colors.black.withOpacity(0.2),
//                                     offset: const Offset(0, 2),
//                                     blurRadius: 4,
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             const SizedBox(height: 8),
//
//                             // الوصف
//                             if (banner.bannersDescription != null)
//                               Text(
//                                 banner.bannersDescription!,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: GoogleFonts.cairo(
//                                   fontSize: 13,
//                                   color: Colors.white.withOpacity(0.95),
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//
//                             const SizedBox(height: 16),
//
//                             // زر التفاصيل
//                             // Container(
//                             //   padding: const EdgeInsets.symmetric(
//                             //     horizontal: 16,
//                             //     vertical: 6,
//                             //   ),
//                             //   decoration: BoxDecoration(
//                             //     color: Colors.white,
//                             //     borderRadius: BorderRadius.circular(25),
//                             //     boxShadow: [
//                             //       BoxShadow(
//                             //         color: Colors.black.withOpacity(0.15),
//                             //         blurRadius: 10,
//                             //         offset: const Offset(0, 4),
//                             //       ),
//                             //     ],
//                             //   ),
//                             //   child: Row(
//                             //     mainAxisSize: MainAxisSize.min,
//                             //     children: [
//                             //       Text(
//                             //         'تسوق الآن',
//                             //         style: GoogleFonts.cairo(
//                             //           fontSize: 13,
//                             //           fontWeight: FontWeight.bold,
//                             //           color: colorPair[0],
//                             //         ),
//                             //       ),
//                             //       const SizedBox(width: 4),
//                             //       Icon(
//                             //         Icons.arrow_forward_rounded,
//                             //         color: colorPair[0],
//                             //         size: 16,
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//
//                       // الجانب الأيمن - الصورة (إذا وجدت)
//                       if (banner.bannersUrlImage != null)
//                         Expanded(
//                           child: Container(
//                             height: double.infinity,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.15),
//                                   blurRadius: 20,
//                                   offset: const Offset(0, 8),
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(16),
//                               child:CustomImage(url: banner.bannersUrlImage!,)
//                               //
//                               // Image.network(
//                               //   banner.bannersUrlImage!,
//                               //   fit: BoxFit.cover,
//                               //   errorBuilder: (context, error, stackTrace) {
//                               //     return Container(
//                               //       decoration: BoxDecoration(
//                               //         gradient: LinearGradient(
//                               //           colors: [
//                               //             Colors.white.withOpacity(0.2),
//                               //             Colors.white.withOpacity(0.1),
//                               //           ],
//                               //         ),
//                               //         borderRadius: BorderRadius.circular(16),
//                               //       ),
//                               //       child: Center(
//                               //         child: Icon(
//                               //           Icons.image_rounded,
//                               //           size: 48,
//                               //           color: Colors.white.withOpacity(0.7),
//                               //         ),
//                               //       ),
//                               //     );
//                               //   },
//                               // ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//
//                 // شارة الزاوية
//                 Positioned(
//                   top: 12,
//                   left: 12,
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.25),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       ['💥', '🎉', '🎁', '✨', '🔥', '🚀'][
//                       index % 6
//                       ],
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     })
//         .toList()
//         .reversed
//         .toList();
//
//     return Column(
//       children: [
//         // السلايدر
//         RepaintBoundary(
//           child: CarouselSlider(
//             carouselController: _carouselController,
//             options: CarouselOptions(
//               viewportFraction: 0.92,
//               height: 180,
//               enableInfiniteScroll: true,
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 4),
//               autoPlayAnimationDuration: const Duration(milliseconds: 800),
//               autoPlayCurve: Curves.easeInOutCubic,
//               enlargeCenterPage: true,
//               enlargeFactor: 0.15,
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               },
//             ),
//             items: imageSliders,
//           ),
//         ),
//
//         const SizedBox(height: 16),
//
//         // مؤشرات الصفحات
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: imageSliders.asMap().entries.map((entry) {
//             final isActive = _currentIndex == entry.key;
//             return GestureDetector(
//               onTap: () => _carouselController.animateToPage(entry.key),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 width: isActive ? 24 : 8,
//                 height: 8,
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4),
//                   gradient: isActive
//                       ? LinearGradient(
//                     colors: [
//                       ColorManager.primaryColor,
//                       ColorManager.primaryColor.withOpacity(0.7),
//                     ],
//                   )
//                       : null,
//                   color: isActive ? null : ColorManager.grey.withOpacity(0.3),
//                   boxShadow: isActive
//                       ? [
//                     BoxShadow(
//                       color: ColorManager.primaryColor.withOpacity(0.4),
//                       blurRadius: 6,
//                       offset: const Offset(0, 2),
//                     ),
//                   ]
//                       : null,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }