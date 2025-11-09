// import 'package:fada_alhalij_web/core/di/di.dart';
// import 'package:fada_alhalij_web/core/resources/assets_manager.dart';
// import 'package:fada_alhalij_web/core/resources/color_manager.dart';
// import 'package:fada_alhalij_web/features/app_search/presentation/bloc/search_cubit.dart';
//
// import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
// import 'package:fada_alhalij_web/features/products/presentation/cubit/products_cubit.dart';
// import 'package:fada_alhalij_web/features/products/presentation/widgets/products_body.dart';
// import 'package:fada_alhalij_web/core/widgets/ske_grid_product.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
//
//
// import '../../../../core/resources/style_manager.dart';
//
// class ProductsView extends StatefulWidget {
//   const ProductsView({super.key, required this.idCategory});
//
//   final String? idCategory;
//
//   @override
//   State<ProductsView> createState() => _ProductsViewState();
// }
//
// class _ProductsViewState extends State<ProductsView> {
//   late ProductsCubit viewModel;
//
//   @override
//   void initState() {
//     viewModel = getIt<ProductsCubit>();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     viewModel.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: viewModel..getProductsData(idCategory: widget.idCategory ?? ''),
//       child: BlocBuilder<ProductsCubit, ProductsState>(
//         builder: (context, state) {
//           if (state is ProductsSuccess) {
//             List<ProductsRelations> products =
//                 state.productsModelEntity?.productsData?.productsRelations?.reversed.toList() ??
//                 [];
//             SearchCubit.get(context).searchProducts(products.reversed.toList());
//             return products.isNotEmpty
//                 ? ProductsBody(products: products,)
//                 : Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 24),
//                       Text(
//                         'لا يوجد منتجات',
//                         style: getSemiBoldStyle(
//                           color: ColorManager.indigoDark,
//                           fontSize: 20,
//                         ),
//                       ),
//                       SizedBox(height: 24),
//                       AspectRatio(
//                         aspectRatio: 16 / 9,
//                         child: SvgPicture.asset(Assets.emptyList),
//                       ),
//                     ],
//                   ),
//                 );
//           }
//
//           if (state is ProductsLoading) {
//             return SkeGridProduct();
//           }
//
//           return Center(
//             child: CircularProgressIndicator(color: ColorManager.primaryColor),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:fada_alhalij_web/core/di/di.dart';
import 'package:fada_alhalij_web/core/resources/assets_manager.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:fada_alhalij_web/features/app_search/presentation/bloc/search_cubit.dart';

import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
import 'package:fada_alhalij_web/features/products/presentation/cubit/products_cubit.dart';
import 'package:fada_alhalij_web/features/products/presentation/widgets/products_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/style_manager.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key, required this.idCategory});

  final String? idCategory;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late ProductsCubit viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    viewModel = getIt<ProductsCubit>();
    _setupScrollListener();
    super.initState();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      // عندما يصل المستخدم لـ 80% من المحتوى
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        viewModel.loadMoreProducts(); // ← يطلب المزيد من البيانات
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel..getProductsData(idCategory: widget.idCategory ?? ''),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsSuccess || state is ProductsLoadingMore) {
            List<ProductsRelations> products = [];
            bool hasMoreData = true;

            if (state is ProductsSuccess) {
              products = state.productsModelEntity?.productsData
                  ?.productsRelations ??
                  [];
              hasMoreData = state.hasMoreData;
            } else if (state is ProductsLoadingMore) {
              products = state.currentProducts;
            }

            SearchCubit.get(context).searchProducts(products.reversed.toList());

            return products.isNotEmpty
                ? ProductsBody(
              scrollController: _scrollController,
              hasMoreData: hasMoreData,
            )
                : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Text(
                    'لا يوجد منتجات',
                    style: getSemiBoldStyle(
                      color: ColorManager.indigoDark,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 24),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: SvgPicture.asset(Assets.emptyList),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(color: ColorManager.blue),
          );
        },
      ),
    );
  }
}