import 'package:fada_alhalij_web/core/resources/style_manager.dart';
import 'package:fada_alhalij_web/features/categories/presentation/pages/categories.dart';
import 'package:fada_alhalij_web/features/layout/presentation/cubit/layout_cubit.dart';

import 'package:fada_alhalij_web/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../app_search/presentation/bloc/search_cubit.dart';
import '../cubit/categories_cubit.dart';

class AppBarCategories extends StatelessWidget {
  const AppBarCategories({super.key});

  @override
  Widget build(BuildContext context) {
    var searchCubit = SearchCubit.get(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:
          (didPop, result) =>  LayoutCubit.get(context).changeIndex(0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                LayoutCubit.get(context).changeIndex(0);
              },
              child: Container(
                height: 45,
                width: 45,
                padding: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade200),
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),


            SizedBox(width: 14),
            Expanded(
              child: CustomTextFormField(
                controller: searchCubit.searchController,
                hintText: AppLocalizations.of(context)?.whatAreSearch,
                onChanged: (value) {
                  searchCubit.updateSearch(value);
                },
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16),
                  child: SvgPicture.asset(Assets.imagesSearch),
                ),
                suffix: IconButton(
                  icon: Icon(Icons.clear,size: 16,),
                  onPressed: () {
                    SearchCubit.get(context).clearSearch(); // مسح النص
                  },
                ),// إخفاء أيقونة المسح إذا كان الحقل فارغًا
              )

            ),
          ],
        ),
      ),
    );
  }
}
