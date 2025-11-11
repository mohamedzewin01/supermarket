import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../l10n/app_localizations.dart';

class SearchTextFiled extends StatelessWidget {
  const SearchTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        onTap: () => LayoutCubit.get(context).changeIndex(2),
        controller: TextEditingController(),
        hintText: AppLocalizations.of(context)?.whatAreSearch,
        enabled: true,
        onChanged: (value) {
          // updateSearch(value);
        },
        prefixIcon: Padding(
          padding: EdgeInsets.all(16),
          child: SvgPicture.asset(Assets.imagesSearch),
        ),
        // suffix: Icon(Icons.search, color: ColorManager.placeHolderColor2),
      ),
    );
  }
}
