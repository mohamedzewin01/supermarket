import 'package:auto_size_text/auto_size_text.dart';
import 'package:fada_alhalij_web/core/functions/launch_url.dart';
import 'package:fada_alhalij_web/core/resources/curve_clipper.dart';
import 'package:fada_alhalij_web/core/resources/style_manager.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/features/home/data/models/response/home_model_response_dto.dart';
import 'package:fada_alhalij_web/localization/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';

class AppBarBody extends StatelessWidget {
  const AppBarBody({super.key, this.store});

  final Store? store;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorManager.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
      ),
      title: AutoSizeText(
        '${store?.storeName} ${PromotionalMessages.goldenOpportunityDontMiss}' ??
            '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: getSemiBoldStyle(color: ColorManager.white, fontSize: 18),
      ),
      centerTitle: true,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipPath(
        clipper: InwardCurveClipper(),
        child: Container(color: ColorManager.secondaryColor),
      ),
      leading: GestureDetector(
        onTap: () async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              Future(() async {
                await CustomLaunchUrl.launchUrlShareWeb(
                  title: CacheService.getData(key: CacheKeys.storeName),
                  details: CacheService.getData(
                    key: CacheKeys.storeDescription,
                  ),
                  urlPreview: CacheService.getData(
                    key: CacheKeys.storeUrlImage,
                  ),
                  phone: CacheService.getData(key: CacheKeys.storePhone),
                );
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              });
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: ColorManager.primaryColor),
                      const SizedBox(height: 16),
                      Text(
                        'جارٍ التحضير...',
                        style: getSemiBoldStyle(color: ColorManager.primaryColor,fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            Assets.share,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 25,
            height: 25,
          ),
        ),
      ),


      // StatefulBuilder(
      //   builder: (BuildContext context, StateSetter setState) {
      //     String lang = context.read<LocaleCubit>().state.languageCode;
      //     String title = lang == 'ar' ? 'EN' : 'AR';
      //     String lang2 = lang == 'ar' ? 'en' : 'ar';
      //
      //     return GestureDetector(
      //       onTap: () {
      //         context.read<LocaleCubit>().changeLanguage(lang2);
      //         setState(() {});
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(16),
      //         child: Center(
      //           child: Text(
      //             title,
      //             style: getSemiBoldStyle(
      //               color: ColorManager.white,
      //               fontSize: 20,
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      actions: [
        Image.asset(Assets.logo3, scale: 1, fit: BoxFit.fill,height: 40,width: 40,),
      ],
    );
  }
}
