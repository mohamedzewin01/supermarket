import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:flutter/material.dart';


class CategoryItem extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool isSelected;

  const CategoryItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      /*margin: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall, horizontal: 2),*/
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: isSelected
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).cardColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.cardColor.withOpacity(0.05)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  '$icon',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal:8
                    // Dimensions.paddingSizeExtraSmall
                ),
                child: Text(
                  title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context)
                            .bottomNavigationBarTheme
                            .unselectedItemColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
