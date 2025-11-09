import 'package:fada_alhalij_web/core/widgets/custom_product_card.dart';
import 'package:fada_alhalij_web/features/app_search/presentation/bloc/search_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
// class ProductsBody extends StatelessWidget {
//   const ProductsBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: BlocBuilder<SearchCubit, SearchState>(
//           builder: (context, state) {
//             return LayoutBuilder(
//               builder: (context, constraints) {
//                 double mainAxisExtent = (constraints.maxWidth > 500) ? 310 : 280;
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
//                   child: GridView.builder(
//                     itemCount: SearchCubit.get(context).filteredProducts.length,
//                     physics: BouncingScrollPhysics(
//                       parent: AlwaysScrollableScrollPhysics(),
//                     ),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 12,
//                       crossAxisSpacing: 12,
//                       childAspectRatio: .65,
//                       mainAxisExtent: mainAxisExtent,
//                       // هنا بتحكم في حجم الكرت
//                     ),
//                     itemBuilder: (context, index) => CustomProductCardWidget(
//                       product: SearchCubit.get(context).filteredProducts[index],
//                     ),
//                   ),
//                 );
//
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key, required this.products});

  final List<ProductsRelations> products ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double mainAxisExtent = (constraints.maxWidth > 500) ? 310 : 280;
            return Padding(
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: GridView.builder(
                itemCount: products.length,
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: .65,
                  mainAxisExtent: mainAxisExtent,
                  // هنا بتحكم في حجم الكرت
                ),
                itemBuilder: (context, index) => CustomProductCardWidget(
                  product: products[index],
                ),
              ),
            );

          },
        ),
      ),
    );
  }
}