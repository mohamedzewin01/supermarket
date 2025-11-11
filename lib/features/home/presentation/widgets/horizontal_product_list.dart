import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/core/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import '../../data/models/response/home_model_response_dto.dart';

class BestDealsProductList extends StatelessWidget {
  const BestDealsProductList({super.key, required this.bestDeals});

  final List<ProductsBestDeals>? bestDeals;

  @override
  Widget build(BuildContext context) {
    List<ProductsBestDeals>? bestDeals10 = bestDeals ?? [];
    return LayoutBuilder(
      builder: (context, constraints) {
        double mainAxisExtent = (constraints.maxWidth > 500) ? 140 : 180;
        return bestDeals10.isNotEmpty
            ? SizedBox(
          height: 310,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: bestDeals10.length,
              scrollDirection: Axis.horizontal,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                // childAspectRatio: 0.90,
                mainAxisExtent: mainAxisExtent,
              ),
              itemBuilder:
                  (context, index) => CustomProductCardWidget(
                product: bestDeals10[index].toProductsRelations(),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8,
              ), // تأكد من إزالة أي padding
            ),
          ),
        )
            : Center(
          child: AutoSizeText(
            'جاري تجهز العروض ...',
            style: getSemiBoldStyle(color: ColorManager.red, fontSize: 16),
          ),
        );
      },
    );
  }
}

///
// SizedBox(
//   height: 220,
//   child:
//       bestDeals10.isNotEmpty
//           ? ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: bestDeals10.length,
//             itemBuilder: (context, index) {
//
//               return FittedBox(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         CustomProductCardWidget(
//                           product: bestDeals10[index].toProductsRelations(),
//                         ),
//                         SizedBox(width: 8),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           )
//           : Center(
//             child: AutoSizeText(
//               'جاري تجهز العروض ...',
//               style: getSemiBoldStyle(
//                 color: ColorManager.red,
//                 fontSize: 16,
//               ),
//             ),
//           ),
// );

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:manarat_amjad/core/resources/color_manager.dart';
// import 'package:manarat_amjad/core/resources/style_manager.dart';
// import 'package:manarat_amjad/core/widgets/custom_product_card.dart';
// import 'package:flutter/material.dart';
// import '../../data/models/response/home_model_response_dto.dart';
//
// class BestDealsProductList extends StatefulWidget {
//   const BestDealsProductList({super.key, required this.bestDeals});
//
//   final List<ProductsBestDeals>? bestDeals;
//
//   @override
//   State<BestDealsProductList> createState() => _BestDealsProductListState();
// }
//
// class _BestDealsProductListState extends State<BestDealsProductList>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
//     );
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<ProductsBestDeals>? bestDeals10 =
//         widget.bestDeals?.toList().reversed.toList() ?? [];
//
//     return bestDeals10.isNotEmpty
//         ? FadeTransition(
//       opacity: _fadeAnimation,
//       child: Container(
//         height: 520,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.white.withOpacity(0.1),
//               Colors.transparent,
//             ],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//           child: GridView.builder(
//             itemCount: bestDeals10.length,
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               mainAxisExtent: 240,
//             ),
//             itemBuilder: (context, index) {
//               return TweenAnimationBuilder<double>(
//                 tween: Tween(begin: 0.0, end: 1.0),
//                 duration: Duration(milliseconds: 400 + (index * 100)),
//                 curve: Curves.easeOutCubic,
//                 builder: (context, value, child) {
//                   return Transform.scale(
//                     scale: value,
//                     child: Opacity(
//                       opacity: value,
//                       child: _buildProductCard(
//                         bestDeals10[index],
//                         index,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//             padding: const EdgeInsets.symmetric(
//               vertical: 8,
//               horizontal: 4,
//             ),
//           ),
//         ),
//       ),
//     )
//         : _buildEmptyState(context);
//   }
//
//   Widget _buildProductCard(ProductsBestDeals product, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // البطاقة الأساسية
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: CustomProductCardWidget(
//               product: product.toProductsRelations(),
//             ),
//           ),
//
//           // شارة "جديد" أو "مميز"
//           if (index < 3)
//             Positioned(
//               top: 8,
//               right: 8,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       ColorManager.red,
//                       ColorManager.deepOrange,
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: ColorManager.red.withOpacity(0.4),
//                       blurRadius: 8,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(
//                       Icons.star_rounded,
//                       color: Colors.white,
//                       size: 14,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       'HOT',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: ColorManager.primaryColor.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     ColorManager.primaryColor.withOpacity(0.2),
//                     ColorManager.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.local_fire_department_rounded,
//                 color: ColorManager.red,
//                 size: 48,
//               ),
//             ),
//             const SizedBox(height: 16),
//             AutoSizeText(
//               'جاري تجهيز العروض...',
//               style: getSemiBoldStyle(
//                 color: ColorManager.textColor,
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               width: 40,
//               height: 40,
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                   ColorManager.primaryColor,
//                 ),
//                 strokeWidth: 3,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }