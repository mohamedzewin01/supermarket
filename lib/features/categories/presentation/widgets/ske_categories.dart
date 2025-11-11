import 'package:manarat_amjad/core/api/api_constants.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/ske_grid_product.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeCategories extends StatelessWidget {
  const SkeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Skeletonizer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                spacing: 12,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(3, (index) {
                      return Card(
                        elevation: 4,
                        child: Container(
                          height: 35,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            // backgroundColorsCategories[index],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: Text(
                                  '123456',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.white,
                                  ),
                                  textAlign: TextAlign.center,

                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                height: 35,
                                width: 35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    8,
                                  ),
                                  child: Image.network(
                                    '${ApiConstants.baseUrlImage}7987resized_1744890678567.jpeg',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                        Icon(
                                          Icons.broken_image,
                                          size: 18,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          SkeGridProduct(),
        ],
      ),
    );
  }
}
