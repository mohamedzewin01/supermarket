import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_product_card.dart';
import 'package:manarat_amjad/core/widgets/custom_sliver_app_bar.dart';

import 'package:manarat_amjad/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:manarat_amjad/features/products/data/models/response/get_products_by_category_model.dart';
class SkBestDeals extends StatelessWidget {
  const SkBestDeals({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: AppLocalizations.of(context)!.bestDeals,

          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                5,
                    (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'dddddddddd',
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 260,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, productIndex) {
                            return CustomProductCardWidget(
                              product: ProductsRelations(
                                categoryName: 'sasa',
                                imageCover:
                                '1647WhatsApp Image 2025-03-25 at 10.16.23 PM.jpeg',
                                descount: 12,
                                description: 'sssssssssssssssssssssssss',
                                productName: 'ssssssss',
                                productPrice: 25,
                                productPriceAfterDiscount: 10,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}