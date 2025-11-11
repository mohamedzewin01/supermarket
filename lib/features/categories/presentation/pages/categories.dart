import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/widgets/custom_sliver_app_bar.dart';
import 'package:manarat_amjad/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../widgets/app_bar_categories.dart';
import '../widgets/category_bar.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  late CategoriesCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<CategoriesCubit>();
    super.initState();
  }
  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocProvider(
        create: (context) => viewModel..getCategories(),
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: CustomScrollView(
              slivers: [
                CustomSliverAppBar(title: 'الاقسام',isBack: true,),
                CategoryBar(viewModel: viewModel)
              ],
            ),
          ),
        ),
      ),


    );
  }
}



