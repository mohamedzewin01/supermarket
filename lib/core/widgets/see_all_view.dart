import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../resources/color_manager.dart';




class SeeAllView extends StatelessWidget {
  const SeeAllView({
    super.key,
    required this.context,
    required this.name,
    required this.onTapAction,
  });

  final BuildContext context;
  final String name;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: getSemiBoldStyle(color: ColorManager.black, fontSize: 18,),
          ),
          InkResponse(
            onTap: () {
              onTapAction();
            },
            child: Text(
              AppLocalizations.of(context)!.seeAll,
              style: TextStyle(
                  fontSize: 14,
                  color: ColorManager.primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
