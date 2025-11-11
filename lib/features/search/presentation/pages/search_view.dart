import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/core/widgets/custom_sliver_app_bar.dart';
import 'package:manarat_amjad/features/search/presentation/widget/grid_product_search.dart';
import 'package:manarat_amjad/features/search/presentation/widget/search_bar.dart';
import 'package:manarat_amjad/features/search/presentation/widget/wrap_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit viewModel;
  final ScrollController _scrollController = ScrollController();
  bool showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<SearchCubit>();
    viewModel.searchProducts(limit: 10);
    _scrollController.addListener(() {
      final isScrolling = _scrollController.position.pixels > 500;

      if (isScrolling != showScrollToTopButton) {
        setState(() {
          showScrollToTopButton = isScrolling;
        });
      }

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        viewModel.loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  CustomSliverAppBar(title: 'البحث',isBack: true,),
                  CustomSearchBar(viewModel: viewModel),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight*3, left: 16, right: 16),
                    sliver: GridProductSearch(),
                  ),
                ],
              ),
              if (showScrollToTopButton)
                Positioned(
                  bottom: 80,
                  right: 20,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      _scrollController.animateTo(
                        0,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    backgroundColor: ColorManager.indigoLight,
                    elevation: 6,  // ظل خفيف
                    tooltip: 'Scroll to top',  // لون الخلفية
                    child: Icon(
                      Icons.arrow_upward,  // سهم لأعلى
                      color: Colors.white,  // لون الأيقونة أبيض عادة
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
