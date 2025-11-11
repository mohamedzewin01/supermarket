


import 'package:manarat_amjad/core/widgets/custom_product_card.dart';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:manarat_amjad/features/products/data/models/response/get_products_by_category_model.dart';
class SkeProductsRelation extends StatelessWidget {
  const SkeProductsRelation({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double mainAxisExtent =
          (constraints.maxWidth > 500) ? 300 : 200;
          return SizedBox(
            height: 310,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GridView.builder(

                itemCount: 3,
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.80,
                  mainAxisExtent: mainAxisExtent,
                ),
                itemBuilder:
                    (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CustomProductCardWidget(
                    product:ProductsRelations(
                      productName: "sdsd ",
                      categoryImage: " sdsd",
                      descount: 0,
                      productPrice: 0,
                      productPriceAfterDiscount: 0,
                      imageCover:  '7987resized_1744890678567.jpeg',


                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ), // تأكد من إزالة أي padding
              ),
            ),
          );
        },
      ),
    );
  }
}
