import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';


class RialIcon extends StatelessWidget {
  final double size;
  final Color? color;
  const RialIcon({super.key, this.size = 18, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Image.asset(
        Assets.imagesRial,
        height: size,
        width: size,
        color:color ,
      ),
    );
  }
}
