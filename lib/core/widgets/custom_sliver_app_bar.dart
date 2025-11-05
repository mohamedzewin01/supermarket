import 'package:auto_size_text/auto_size_text.dart';
import 'package:fada_alhalij_web/core/functions/launch_url.dart';
import 'package:fada_alhalij_web/core/resources/assets_manager.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:fada_alhalij_web/core/resources/style_manager.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';


// class CustomSliverAppBar extends StatelessWidget {
//   const CustomSliverAppBar({
//     super.key,
//     required this.title,
//     this.leading,
//     this.actions, this.onPressed,
//   });
//
//   final String title;
//   final Widget? leading;
//   final List<Widget>? actions;
//   final void Function()? onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       backgroundColor: ColorManager.primaryColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
//       ),
//       title: AutoSizeText(
//         title ?? '',
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//         style: getSemiBoldStyle(color: ColorManager.white, fontSize: 16),
//       ),
//       centerTitle: true,
//       floating: true,
//       snap: true,
//       automaticallyImplyLeading: false,
//       flexibleSpace: ClipPath(
//         clipper: InwardCurveClipper(),
//         child: Container(color: ColorManager.secondaryColor),
//       ),
//       leading:
//       leading ??
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Container(
//               padding: EdgeInsets.all(1),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: ColorManager.placeHolderColor,
//               ),
//               child: CircleAvatar(
//                 backgroundColor: ColorManager.white,
//                 child: Image.asset(Assets.logo, scale: 1, fit: BoxFit.fill),
//               ),
//             ),
//           ),
//
//       actions:
//       actions ??
//           [
//             IconButton(
//               onPressed: onPressed,
//               icon: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 22,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//     );
//   }
// }

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final bool showLogo;
  final bool pinned;
  final bool isBack;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.showLogo = true,
    this.pinned = true,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: pinned,
      expandedHeight: 70,
      backgroundColor: ColorManager.primaryColor,
      centerTitle: true,

      title: AutoSizeText(
        title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: getSemiBoldStyle(color: ColorManager.white, fontSize: 16),
      ),
      leading:
      isBack
          ? Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap:
          onBackTap ??
                  () => LayoutCubit.get(context).changeIndex(0),
          child: Container(
            padding: const EdgeInsets.only(right: 7),
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
      )
          : CustomShareInfoApp(),
      actions:
      showLogo
          ? [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
          child: Image.asset(Assets.logo3, scale: 1),
        ),
      ]
          : [],
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(24),
        child: Container(
          height: 22,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomShareInfoApp extends StatefulWidget {
  const CustomShareInfoApp({
    super.key,
  });

  @override
  State<CustomShareInfoApp> createState() => _CustomShareInfoAppState();
}

class _CustomShareInfoAppState extends State<CustomShareInfoApp> {
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _isSharing = true;
        });
        try {
          await CustomLaunchUrl.launchUrlShareWeb(

            title: CacheService.getData(
              key: CacheKeys.storeName,
            ),
            details: CacheService.getData(
              key: CacheKeys.storeDescription,
            ),
            urlPreview: CacheService.getData(
              key: CacheKeys.storeUrlImage,
            ),
            phone: CacheService.getData(
              key: CacheKeys.storePhone,
            ),
          );
        } catch (e) {
          debugPrint(e.toString());
        } finally {
          setState(() {
            _isSharing = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorManager.primaryColor,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder:
              (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child:
          _isSharing
              ? const SizedBox(
            key: ValueKey("loading"),
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Icon(
            key: ValueKey("icon"),
            size: 20,
            Icons.share, // استخدم أيقونة المشاركة
            color: ColorManager.white,
          ),
        ),
      ),

    );



  }
}
