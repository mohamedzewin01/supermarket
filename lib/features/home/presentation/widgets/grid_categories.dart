//
import 'package:manarat_amjad/core/resources/routes_manager.dart';
import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/categories_view.dart';
import '../../data/models/response/home_model_response_dto.dart';

class GridCategories extends StatelessWidget {
  const GridCategories({super.key, required this.categories});

  final List<Categories> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      // color: ColorManager.primaryColor,
      child:categories.isNotEmpty? GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder:
            (context, index) => GestureDetector(
              onTap: () {
                if(context.mounted) {
                  LayoutCubit.get(context).changeIndex(1,tabIndex: index);
                }
              },
              child: CategoriesView(
                imagePath: categories[index].categoryImage ?? '',
                catName: categories[index].categoryName ?? '',
              ),
            ),
      ):SizedBox(),
    );
  }
}

// import 'package:manarat_amjad/core/resources/routes_manager.dart';
// import 'package:manarat_amjad/core/resources/color_manager.dart';
// import 'package:flutter/material.dart';
// import '../../../../core/widgets/categories_view.dart';
// import '../../data/models/response/home_model_response_dto.dart';
//
// class GridCategories extends StatefulWidget {
//   const GridCategories({super.key, required this.categories});
//
//   final List<Categories> categories;
//
//   @override
//   State<GridCategories> createState() => _GridCategoriesState();
// }
//
// class _GridCategoriesState extends State<GridCategories> {
//   int? _hoveredIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 190,
//       child: widget.categories.isNotEmpty
//           ? GridView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.categories.length,
//         physics: const BouncingScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 4,
//           crossAxisSpacing: 4,
//           // childAspectRatio: 0.85,
//         ),
//         itemBuilder: (context, index) {
//           final category = widget.categories[index];
//           final isHovered = _hoveredIndex == index;
//
//           return MouseRegion(
//             onEnter: (_) => setState(() => _hoveredIndex = index),
//             onExit: (_) => setState(() => _hoveredIndex = null),
//             cursor: SystemMouseCursors.click,
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pushNamed(
//                   context,
//                   RoutesManager.categoriesAdaptive,
//                   arguments: category,
//                 );
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 transform: Matrix4.identity()
//                   ..scale(isHovered ? 1.05 : 1.0)
//                   ..rotateZ(isHovered ? 0.01 : 0.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Colors.white,
//                         isHovered
//                             ? ColorManager.primaryColor.withOpacity(0.1)
//                             : Colors.white,
//                       ],
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: isHovered
//                             ? ColorManager.primaryColor.withOpacity(0.3)
//                             : Colors.black.withOpacity(0.08),
//                         blurRadius: isHovered ? 15 : 10,
//                         offset: Offset(0, isHovered ? 8 : 4),
//                         spreadRadius: isHovered ? 1 : 0,
//                       ),
//                     ],
//                     border: Border.all(
//                       color: isHovered
//                           ? ColorManager.primaryColor.withOpacity(0.4)
//                           : Colors.transparent,
//                       width: 2,
//                     ),
//                   ),
//                   child: Stack(
//                     children: [
//                       // الخلفية المتدرجة
//                       if (isHovered)
//                         Positioned.fill(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               gradient: LinearGradient(
//                                 begin: Alignment.topCenter,
//                                 end: Alignment.bottomCenter,
//                                 colors: [
//                                   Colors.transparent,
//                                   ColorManager.primaryColor.withOpacity(0.05),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//                       // المحتوى
//                       Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             // الأيقونة المحسنة
//                             Hero(
//                               tag: 'category_${category.categoryId}',
//                               child: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       ColorManager.primaryColor.withOpacity(0.2),
//                                       ColorManager.primaryColor.withOpacity(0.1),
//                                     ],
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: ColorManager.primaryColor.withOpacity(0.2),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 3),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipOval(
//                                   child: Image.network(
//                                     category.categoryImage ?? '',
//                                     width: 50,
//                                     height: 50,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         width: 50,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               ColorManager.primaryColor,
//                                               ColorManager.secondaryColor,
//                                             ],
//                                           ),
//                                         ),
//                                         child: const Icon(
//                                           Icons.category_rounded,
//                                           color: Colors.white,
//                                           size: 30,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             const SizedBox(height: 8),
//
//                             // اسم القسم
//                             Flexible(
//                               child: Text(
//                                 category.categoryName ?? '',
//                                 maxLines: 2,
//                                 textAlign: TextAlign.center,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: isHovered
//                                       ? FontWeight.bold
//                                       : FontWeight.w600,
//                                   color: isHovered
//                                       ? ColorManager.primaryColor
//                                       : ColorManager.textColor,
//                                   height: 1.2,
//                                 ),
//                               ),
//                             ),
//
//                             // مؤشر الانتقال
//                             if (isHovered)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Icon(
//                                   Icons.arrow_forward_rounded,
//                                   size: 16,
//                                   color: ColorManager.primaryColor,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//
//                       // أيقونة الإشعار (اختياري)
//                       if (isHovered)
//                         Positioned(
//                           top: 8,
//                           right: 8,
//                           child: Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: BoxDecoration(
//                               color: ColorManager.primaryColor,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: ColorManager.primaryColor.withOpacity(0.4),
//                                   blurRadius: 6,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: const Icon(
//                               Icons.arrow_forward_rounded,
//                               size: 12,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       )
//           : const SizedBox(),
//     );
//   }
// }