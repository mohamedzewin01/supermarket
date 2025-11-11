// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:manarat_amjad/core/resources/color_manager.dart';
// import 'package:manarat_amjad/core/resources/style_manager.dart';
// import 'package:manarat_amjad/core/widgets/custom_product_card.dart';
// import 'package:manarat_amjad/core/widgets/custom_text_form_field.dart';
// import 'package:manarat_amjad/features/home/data/models/response/home_model_response_dto.dart';
// import 'package:manarat_amjad/l10n/app_localizations.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
//
// class AllBestDealsView extends StatefulWidget {
//   const AllBestDealsView({super.key});
//
//   @override
//   State<AllBestDealsView> createState() => _AllBestDealsViewState();
// }
//
// class _AllBestDealsViewState extends State<AllBestDealsView> {
//   List<ProductsBestDeals>? filteredProducts;
//   List<ProductsBestDeals>? bestDeals;
//   String query = "";
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {
//         bestDeals =
//             ModalRoute.of(context)?.settings.arguments
//                 as List<ProductsBestDeals>?;
//         filteredProducts = bestDeals;
//       });
//     });
//   }
//
//   void updateSearch(String searchQuery) {
//     setState(() {
//       query = searchQuery;
//       if (searchQuery.isEmpty) {
//         filteredProducts = bestDeals;
//       } else {
//         filteredProducts =
//             bestDeals
//                 ?.where(
//                   (product) =>
//                       product.productName!.toLowerCase().contains(
//                         searchQuery.toLowerCase(),
//                       ) ||
//                       product.description!.toLowerCase().contains(
//                         searchQuery.toLowerCase(),
//                       ),
//                 )
//                 .toList();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: GestureDetector(
//         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//         child: Scaffold(
//           floatingActionButtonLocation:
//           FloatingActionButtonLocation.startFloat,
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: ColorManager.primaryColor,
//             onPressed: () => Navigator.pop(context),
//             child: Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: Center(child: Icon(Icons.arrow_back_ios)),
//             ),
//           ),
//           body: LayoutBuilder(
//             builder: (context, constraints) {
//               int crossAxisCount =
//                   constraints.maxWidth > 900
//                       ? 5
//                       : constraints.maxWidth > 700
//                       ? 3
//                       : 2;
//               return Column(
//                 children: [
//                   Expanded(
//                     child: CustomScrollView(
//                       slivers: [
//                         SliverAppBar(
//                           automaticallyImplyLeading: false,
//                           backgroundColor: ColorManager.primaryColor,
//                           elevation: 10,
//                           pinned: false,
//                           floating: true,
//                           snap: true,
//                           title: Text(
//                             AppLocalizations.of(context)?.bestDeals ?? '',
//                             style: getSemiBoldStyle(
//                               color: ColorManager.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                           actions: [
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 22,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         SliverToBoxAdapter(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 16,right: 16,left: 16),
//                             child: CustomTextFormField(
//                               controller: searchController,
//                               hintText:
//                                   AppLocalizations.of(context)?.whatAreSearch,
//                               // enabled: false,
//                               onChanged: (value) {
//                                 updateSearch(value);
//                               },
//
//                               suffix: Icon(
//                                 Icons.search,
//                                 color: ColorManager.placeHolderColor2,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // SliverToBoxAdapter(child: SizedBox(height: 16)),
//
//                         filteredProducts?.length !=0?  SliverGrid(
//                           delegate: SliverChildBuilderDelegate(
//                             childCount: filteredProducts?.length,
//                             (context, index) => Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: CustomProductCardWidget(
//                                 product:
//                                     filteredProducts?[index]
//                                         .toProductsRelations(),
//                               ),
//                             ),
//                           ),
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: crossAxisCount,
//                                 // crossAxisSpacing: 10,
//                                 // mainAxisSpacing: 10,
//                                 mainAxisExtent: 275,
//                               ),
//                         ):SliverToBoxAdapter(child: Center(
//                           child: AutoSizeText(
//                             'جاري تجهز العروض ...',
//                             style: getSemiBoldStyle(color: ColorManager.red, fontSize: 16),
//                           ),
//                         )),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
