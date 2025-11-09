
import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fada_alhalij_web/core/di/di.dart';
import 'package:fada_alhalij_web/core/functions/is_user_logged_in.dart';
import 'package:fada_alhalij_web/core/resources/assets_manager.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:fada_alhalij_web/core/resources/style_manager.dart';
import 'package:fada_alhalij_web/core/resources/values_manager.dart';
import 'package:fada_alhalij_web/features/analytics/analytics_helper.dart';
import 'package:fada_alhalij_web/features/cart/presentation/cubit/cart_cubit.dart';

import 'package:fada_alhalij_web/features/products/presentation/widgets/product_details.dart';
import 'package:fada_alhalij_web/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../resources/cashed_image.dart';
import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';

class CustomProductCardWidget extends StatelessWidget {
  const CustomProductCardWidget({super.key, this.product});

  final ProductsRelations? product;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      animationDuration: Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(12),
      child: GestureDetector(
        onTap: () {
          AnalyticsHelper.sendProductVisit(productId: product?.idProduct ?? 0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                  ProductDetails(product: product ?? ProductsRelations()),
            ),
          );
        },
        child: Hero(
          tag: '${product?.idProduct}0',
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white60,
              border: Border.all(color: Color(0xffF1F1F5)),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            child: Container(
                              height: 120,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CustomImage(
                                url: product?.imageCover ?? '',


                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              product?.productPriceAfterDiscount != 0
                                  ? product?.productPriceAfterDiscount
                                          .toString() ??
                                      ''
                                  : product?.productPrice.toString() ?? '',
                              style: TextStyle(
                                color: Color(0xffFF324B),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          product?.productPriceAfterDiscount == 0
                              ? SizedBox(height: 10)
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    product?.productPrice.toString() ?? '',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Get.theme.colorScheme.primary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  AutoSizeText(
                                    "${product?.descount}%",
                                    style: TextStyle(
                                      color: Color.fromARGB(
                                        255,
                                        27,
                                        133,
                                        185,
                                      ),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          Container(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              product?.productName ?? "????",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: getSemiBoldStyle(
                                color: ColorManager.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          AutoSizeText(
                            product?.description ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: getSemiBoldStyle(
                              color: ColorManager.placeHolderColor2,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    product?.productPriceAfterDiscount == 0
                        ? SizedBox()
                        : Positioned(
                          top: 0, // to shift little up
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.error,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AutoSizeText(
                                  "${product?.descount}%",
                                  style: getSemiBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: 14,
                                  ),
                                ),
                                AutoSizeText(
                                  AppLocalizations.of(context)!.discount,
                                  style: getSemiBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
                Spacer(),
                ButtonAddToCart(product: product),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonAddToCart extends StatefulWidget {
  const ButtonAddToCart({super.key, required this.product});

  final ProductsRelations? product;

  @override
  State<ButtonAddToCart> createState() => _ButtonAddToCartState();
}

class _ButtonAddToCartState extends State<ButtonAddToCart> {
  late CartCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<CartCubit>();
    super.initState();
  }
  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartAddSuccess) {

            Flushbar(
              message: "تمت إضافة المنتج إلى السلة",
              icon: const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
              flushbarPosition: FlushbarPosition.TOP,  // عشان تظهر من فوق
              margin: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(12),
            ).show(context);

          }
        },
        builder: (context, state) {
          return SizedBox(
            height: 35,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                showAuthOrAddToCartDialog(
                  context,
                  idProduct: widget.product?.idProduct ?? 0,
                );
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder:
                    (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                child:
                    state is CartAddLoading
                        ? Row(
                          key: const ValueKey("loading"),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ],
                        )
                        : Row(
                          key: const ValueKey("button"),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.cart,
                              width: 15,
                              height: 15,
                              colorFilter: const ColorFilter.mode(
                                ColorManager.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: AppSize.s8),
                            Expanded(
                              child: AutoSizeText(
                                "اضافة للسلة",
                                style: getSemiBoldStyle(
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}


