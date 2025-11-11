import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/api/api_constants.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/core/widgets/custom_error_widget.dart';
import 'package:manarat_amjad/core/widgets/ske_grid_product.dart';
import 'package:manarat_amjad/features/categories/presentation/widgets/ske_categories.dart';
import 'package:manarat_amjad/features/home/presentation/pages/home_view.dart';
import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:manarat_amjad/features/products/presentation/pages/products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/values_manager.dart';

import '../../data/models/categories_zone_response.dart';
import '../cubit/categories_cubit.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({super.key, required this.viewModel});

  final CategoriesCubit viewModel;

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int indexTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {
        if(state is CategoriesFail){

          CustomDialog.showErrorDialog(context, message: state.exception.toString());
        }
      },
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          List<Categories>? categoriesZone =
              state.categoriesZoneEntity?.categories ?? [];
          // if (categoriesZone[0].categoryName != 'الكل') {
          //   categoriesZone.insert(0, Categories(categoryName: '  الكل',categoryImage: "all.png"));
          // }
          List<Tab> tabs =
              categoriesZone.asMap().entries.map((entry) {
                int index = entry.key;
                var tab = entry.value;
                return Tab(
                  icon: Card(
                    elevation: 4,
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorManager.indigoLight,
                        // backgroundColorsCategories[index],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              tab.categoryName ?? '',
                              style: getSemiBoldStyle(
                                color: ColorManager.white,
                              ),
                              textAlign: TextAlign.center,

                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '${ApiConstants.baseUrlImage}${tab.categoryImage ?? ''}',
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        Icon(Icons.broken_image, size: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList();
          return SliverFillRemaining(
            hasScrollBody: true,
            child: DefaultTabController(
              length: tabs.length,
              initialIndex: LayoutCubit.get(context).initialTabIndex,
              child: Column(
                children: [
                  TabBar(
                    indicatorAnimation: TabIndicatorAnimation.linear,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    labelColor: ColorManager.primary,
                    dividerColor: Colors.transparent,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s16,
                    ),
                    unselectedLabelColor: ColorManager.placeHolderColor2,
                    unselectedLabelStyle: getSemiBoldStyle(
                      color: ColorManager.offWhite,
                      fontSize: AppSize.s16,
                    ),
                    labelStyle: getSemiBoldStyle(
                      color: ColorManager.primaryColor,
                      fontSize: AppSize.s18,
                    ),
                    isScrollable: true,
                    indicator: const UnderlineTabIndicator(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s6),
                        topRight: Radius.circular(AppSize.s6),
                      ),
                      borderSide: BorderSide(
                        color: ColorManager.primaryColor,
                        width: 4,
                      ),
                    ),
                    indicatorColor: ColorManager.redDark,
                    indicatorWeight: 1,
                    splashBorderRadius: BorderRadius.circular(AppSize.s20),
                    physics: const BouncingScrollPhysics(),
                    tabs: tabs,
                    onTap: (value) {
                      indexTab = value;
                    },
                  ),
                  const SizedBox(height: AppSize.s14),
                  Expanded(
                    child: TabBarView(
                      children:
                          tabs.map((e) {
                            int currentIndex = tabs.indexOf(e);
                            int? idCategory =
                                categoriesZone[currentIndex].categoryId;
                            String id = idCategory?.toString() ?? '';
                            return ProductsView(idCategory: id);
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is CategoriesLoading) {
          return SkeCategories();
        }

        return SliverToBoxAdapter(child: CustomErrorWidget());
      },
    );
  }
}
