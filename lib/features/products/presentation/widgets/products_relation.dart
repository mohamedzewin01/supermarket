import 'package:fada_alhalij_web/core/di/di.dart';
import 'package:fada_alhalij_web/core/widgets/custom_product_card.dart';

import 'package:fada_alhalij_web/features/products/presentation/cubit/products_cubit.dart';
import 'package:fada_alhalij_web/features/products/presentation/widgets/custom_product_card.dart';
import 'package:fada_alhalij_web/features/products/presentation/widgets/product_details.dart';
import 'package:fada_alhalij_web/features/products/presentation/widgets/ske_products_relation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
class ProductsRelation extends StatefulWidget {
  const ProductsRelation({
    super.key,
    required this.idCategory,
    required this.idProduct,
  });

  final String? idCategory;
  final int? idProduct;

  @override
  State<ProductsRelation> createState() => _ProductsRelationState();
}

class _ProductsRelationState extends State<ProductsRelation> {
  late ProductsCubit viewModel;

  @override
  void initState() {
    viewModel = getIt<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel..getProductsData(idCategory: widget.idCategory ?? ''),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsSuccess) {
            List<ProductsRelations> products =
                state.productsModelEntity?.productsData?.productsRelations
                    ?.take(20)
                    .toList() ??
                [];
            products.removeWhere(
              (element) => element.idProduct == widget.idProduct,
            );
            return LayoutBuilder(
              builder: (context, constraints) {
                double mainAxisExtent =
                    (constraints.maxWidth > 500) ? 300 : 200;
                return SizedBox(
                  height: 310,
                  child: GridView.builder(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.80,
                      mainAxisExtent: mainAxisExtent,
                    ),
                    itemBuilder:
                        (context, index) => GestureDetector(

                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CustomProductCardWidget(
                            product: products[index],
                          ),
                        ),
                    padding: EdgeInsets.symmetric(

                      vertical: 16,
                    ),
                  ),
                );
              },
            );
          }
          if(state is ProductsLoading){
          return  SkeProductsRelation();
          }
          return SizedBox();
        },
      ),
    );
  }
}
