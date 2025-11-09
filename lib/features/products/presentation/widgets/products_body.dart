

import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:fada_alhalij_web/core/widgets/custom_product_card.dart';
import 'package:fada_alhalij_web/features/app_search/presentation/bloc/search_cubit.dart';
import 'package:fada_alhalij_web/features/products/presentation/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // الكشف عن الوصول لنهاية القائمة
  void _onScroll() {
    if (_isBottom) {
      final cubit = context.read<ProductsCubit>();
      cubit.loadMoreProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // تحميل عندما نصل إلى 80% من القائمة
    return currentScroll >= (maxScroll * 0.12);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, searchState) {
            return BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {
                if (state is ProductsFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('فشل تحميل المزيد من المنتجات'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, productsState) {
                final products = SearchCubit.get(context).filteredProducts;
                final cubit = context.read<ProductsCubit>();

                return LayoutBuilder(

                  builder:(context, constraints) {
                    double mainAxisExtent = (constraints.maxWidth > 500) ? 310 : 280;
                    return Padding(
                      padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: products.length + (cubit.hasMoreData ? 1 : 0),
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: .65,
                          mainAxisExtent: mainAxisExtent,
                        ),
                        itemBuilder: (context, index) {
                          // عرض المنتجات
                          if (index < products.length) {
                            return CustomProductCardWidget(
                              product: products[index],
                            );
                          }

                          // عرض loading indicator في النهاية
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(
                                color: ColorManager.deepOrange,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },


                );
              },
            );
          },
        ),
      ),
    );
  }
}