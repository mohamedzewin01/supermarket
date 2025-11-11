import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/functions/is_user_logged_in.dart';
import 'package:manarat_amjad/core/functions/launch_url.dart';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/resources/values_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_icon_share.dart';
import 'package:manarat_amjad/core/widgets/custom_sliver_app_bar.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';

import 'package:manarat_amjad/features/products/presentation/widgets/button_add_to_cart_details.dart';
import 'package:manarat_amjad/features/products/presentation/widgets/products_relation.dart';
import 'package:manarat_amjad/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/curve_clipper.dart';
import 'package:manarat_amjad/features/products/data/models/response/get_products_by_category_model.dart';
class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductsRelations product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  title: product.productName ?? '',
                  onBackTap: Navigator.of(context).pop,

                  isBack: true,
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Hero(
                        tag: '${product.idProduct}00.00',
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 18 / 12,
                              child: CustomImage(url: product.imageCover ?? ''),
                            ),
                            Positioned(

                              bottom: 0,
                              top: 0,
                              child: Column(
                                children: [
                                  ButtonAddToCartDetails(product: product),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorManager.primaryColor,
                                    ),

                                    child: CustomIconShare(
                                      title: product.productName ?? '',
                                      urlPreview: product.imageCover ?? '',
                                      details: product.description ?? '',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Positioned(
                            //   right: 10,
                            //   bottom: 0,
                            //   child: ,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.productPriceAfterDiscount == 0
                                  ? "${product.productPrice ?? 0.00}"
                                  : "${product.productPriceAfterDiscount ?? 0.00} ",
                              style: getSemiBoldStyle(
                                color: ColorManager.black,
                                fontSize: 24,
                              ),
                            ),
                            RialIcon(size: 24, color: ColorManager.black),
                          ],
                        ),
                        SizedBox(height: 14),
                        Text(
                          product.productName ?? "????",
                          style: getSemiBoldStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'تفاصيل المنتج',
                                style: getSemiBoldStyle(
                                  color: ColorManager.blueDark,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            product.description ?? "????",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.justify,

                            style: getSemiBoldStyle(
                              color: ColorManager.placeHolderColor2,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${AppLocalizations.of(context)?.category}: ${product.categoryName}",
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: ColorManager.primaryColor.withAlpha(200),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ' منتج مشابة 🛍️',
                            style: getSemiBoldStyle(
                              color: ColorManager.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: ColorManager.primaryColor.withAlpha(200),
                    child: ProductsRelation(
                      idCategory: product.categoryId.toString(),
                      idProduct: product.idProduct,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          ),
          // Expanded(
          //   flex: 0,
          //
          //   child: Container(
          //     height: 50,
          //     color: ColorManager.placeHolderColor2.withAlpha(200),
          //     clipBehavior: Clip.none,
          //     child: Stack(
          //       clipBehavior: Clip.none,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 16),
          //           child: Column(
          //             children: [
          //               Expanded(
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text(
          //                           product.productPriceAfterDiscount == 0
          //                               ? "${product.productPrice ?? 0.00} ريال "
          //                               : "${product.productPriceAfterDiscount ?? 0.00} ريال ",
          //                           style: getSemiBoldStyle(
          //                             color: ColorManager.white,
          //                             fontSize: 18,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     Spacer(),
          //                     Container(
          //                       padding: EdgeInsets.all(8),
          //                       child: IconButton(
          //                         onPressed: () {
          //                           CustomLaunchUrl.launchUrlShareApp(
          //                             title: product.productName ?? '',
          //                             urlPreview: product.imageCover ?? '',
          //                             details: product.description ?? '',
          //                           );
          //                         },
          //                         icon: SvgPicture.asset(
          //                           Assets.share,
          //                           colorFilter: const ColorFilter.mode(
          //                             Colors.white,
          //                             BlendMode.srcIn,
          //                           ),
          //                           width: 20,
          //                           height: 20,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}


