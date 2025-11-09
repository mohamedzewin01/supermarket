import 'package:fada_alhalij_web/core/di/di.dart';
import 'package:fada_alhalij_web/core/resources/assets_manager.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:fada_alhalij_web/features/app_search/presentation/bloc/search_cubit.dart';

import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
import 'package:fada_alhalij_web/features/products/presentation/cubit/products_cubit.dart';
import 'package:fada_alhalij_web/features/products/presentation/widgets/products_body.dart';
import 'package:fada_alhalij_web/core/widgets/ske_grid_product.dart';
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

  @override
  void initState() {
    viewModel = getIt<ProductsCubit>();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel..getProductsData(idCategory: widget.idCategory ?? ''),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsSuccess) {
            List<ProductsRelations> products =
                state.productsModelEntity?.productsData?.productsRelations?.reversed.toList() ??
                [];
            SearchCubit.get(context).searchProducts(products.reversed.toList());
            return products.isNotEmpty
                ? ProductsBody(products: products,)
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

          if (state is ProductsLoading) {
            return SkeGridProduct();
          }

          return Center(
            child: CircularProgressIndicator(color: ColorManager.primaryColor),
          );
        },
      ),
    );
  }
}
