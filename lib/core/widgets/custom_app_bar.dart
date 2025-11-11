import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final bool showLogo;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.showLogo = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.primaryColor,
      title: Text(
        title,
        style: getSemiBoldStyle(color: ColorManager.white, fontSize: 14),
      ),
      actions: showLogo
          ? [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
          child: Image.asset(Assets.logo3, scale: 1),
        )
      ]
          : [],
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: onBackTap ?? () =>        LayoutCubit.get(context).changeIndex(0),
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
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(24),
        child: Container(
          height: 24,
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
