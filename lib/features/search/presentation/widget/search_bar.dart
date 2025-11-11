import 'package:manarat_amjad/core/api/api_constants.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/features/search/presentation/widget/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../blocs/search_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.viewModel});

  final SearchCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    viewModel.maxPrice = 1000;
                    return showFilterBottomSheet(context, viewModel);
                  },

                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorManager.primaryColor,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: SvgPicture.asset(Assets.filter),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      viewModel.maxPrice = 1000;
                    },
                    child: TypeAheadField(
                      controller: viewModel.searchController,
                      suggestionsCallback: (search) {
                        if (search.isEmpty) {
                          return [];
                        }
                        final normalizedSearch = normalizeText(search);
                        return viewModel.productsSuggested.take(3).where((
                          product,
                        ) {
                          final name = normalizeText(product.productName ?? '');
                          final desc = normalizeText(product.description ?? '');
                          final category = normalizeText(
                            product.categoryName ?? '',
                          );
                          return name.contains(normalizedSearch) ||
                              desc.contains(normalizedSearch) ||
                              category.contains(normalizedSearch);
                        }).toList();
                      },

                      hideOnEmpty: true,
                      direction: VerticalDirection.down,
                      animationDuration: Duration(milliseconds: 300),
                      autoFlipDirection: true,
                      builder: (context, controller, focusNode) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onChanged: (value) {
                            viewModel.maxPrice = 1500;
                            viewModel.searchProducts(search: value);
                            print(value);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'بحث ...',
                          ),
                        );
                      },
                      itemBuilder: (context, product) {
                        String price =
                            product.productPriceAfterDiscount == 0
                                ? '${product.productPrice}'
                                : product.productPriceAfterDiscount.toString();
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              '${ApiConstants.baseUrlImage}${product.imageCover}',
                            ),
                            radius: 20,
                          ),
                          title: Text(product.productName ?? ''),
                          subtitle: Text('السعر: $price'),
                        );
                      },
                      onSelected: (product) {
                        viewModel.searchController.text =
                            product.productName ?? '';
                        viewModel.searchProducts(
                          search: product.productName ?? '',
                        );
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

String normalizeText(String text) {
  return text
      .toLowerCase()
      .replaceAll('أ', 'ا')
      .replaceAll('إ', 'ا')
      .replaceAll('آ', 'ا')
      .replaceAll('ة', 'ه')
      .replaceAll('ى', 'ي')
      .replaceAll(RegExp(r'[^\u0600-\u06FF\s]'), ''); // إزالة الرموز
}
