//
// import 'package:another_flushbar/flushbar.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:fada_alhalij_web/core/di/di.dart';
// import 'package:fada_alhalij_web/core/functions/is_user_logged_in.dart';
// import 'package:fada_alhalij_web/core/resources/assets_manager.dart';
// import 'package:fada_alhalij_web/core/resources/color_manager.dart';
// import 'package:fada_alhalij_web/core/resources/style_manager.dart';
// import 'package:fada_alhalij_web/core/resources/values_manager.dart';
// import 'package:fada_alhalij_web/features/analytics/analytics_helper.dart';
// import 'package:fada_alhalij_web/features/cart/presentation/cubit/cart_cubit.dart';
//
// import 'package:fada_alhalij_web/features/products/presentation/widgets/product_details.dart';
// import 'package:fada_alhalij_web/l10n/app_localizations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import '../resources/cashed_image.dart';
// import 'package:fada_alhalij_web/features/products/data/models/response/get_products_by_category_model.dart';
//
// class CustomProductCardWidget extends StatelessWidget {
//   const CustomProductCardWidget({super.key, this.product});
//
//   final ProductsRelations? product;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       clipBehavior: Clip.antiAlias,
//       animationDuration: Duration(milliseconds: 500),
//       borderRadius: BorderRadius.circular(12),
//       child: GestureDetector(
//         onTap: () {
//           AnalyticsHelper.sendProductVisit(productId: product?.idProduct ?? 0);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder:
//                   (context) =>
//                   ProductDetails(product: product ?? ProductsRelations()),
//             ),
//           );
//         },
//         child: Hero(
//           tag: '${product?.idProduct}0',
//           child: Container(
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(
//               color: Colors.white60,
//               border: Border.all(color: Color(0xffF1F1F5)),
//               borderRadius: BorderRadius.circular(12),
//             ),
//
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 8,
//                               horizontal: 8,
//                             ),
//                             child: Container(
//                               height: 120,
//                               width: double.infinity,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: CustomImage(
//                                 url: product?.imageCover ?? '',
//
//
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             child: AutoSizeText(
//                               product?.productPriceAfterDiscount != 0
//                                   ? product?.productPriceAfterDiscount
//                                           .toString() ??
//                                       ''
//                                   : product?.productPrice.toString() ?? '',
//                               style: TextStyle(
//                                 color: Color(0xffFF324B),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           product?.productPriceAfterDiscount == 0
//                               ? SizedBox(height: 10)
//                               : Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   AutoSizeText(
//                                     product?.productPrice.toString() ?? '',
//                                     style: TextStyle(
//                                       decoration: TextDecoration.lineThrough,
//                                       color: Get.theme.colorScheme.primary,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(width: 8),
//                                   AutoSizeText(
//                                     "${product?.descount}%",
//                                     style: TextStyle(
//                                       color: Color.fromARGB(
//                                         255,
//                                         27,
//                                         133,
//                                         185,
//                                       ),
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                           Container(
//                             alignment: Alignment.center,
//                             child: AutoSizeText(
//                               product?.productName ?? "????",
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                               style: getSemiBoldStyle(
//                                 color: ColorManager.black,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           AutoSizeText(
//                             product?.description ?? "",
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: getSemiBoldStyle(
//                               color: ColorManager.placeHolderColor2,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     product?.productPriceAfterDiscount == 0
//                         ? SizedBox()
//                         : Positioned(
//                           top: 0, // to shift little up
//                           left: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: ColorManager.error,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(8),
//                               ),
//                             ),
//                             padding: EdgeInsets.all(4),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 AutoSizeText(
//                                   "${product?.descount}%",
//                                   style: getSemiBoldStyle(
//                                     color: ColorManager.white,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 AutoSizeText(
//                                   AppLocalizations.of(context)!.discount,
//                                   style: getSemiBoldStyle(
//                                     color: ColorManager.white,
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                   ],
//                 ),
//                 Spacer(),
//                 ButtonAddToCart(product: product),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ButtonAddToCart extends StatefulWidget {
//   const ButtonAddToCart({super.key, required this.product});
//
//   final ProductsRelations? product;
//
//   @override
//   State<ButtonAddToCart> createState() => _ButtonAddToCartState();
// }
//
// class _ButtonAddToCartState extends State<ButtonAddToCart> {
//   late CartCubit viewModel;
//
//   @override
//   void initState() {
//     viewModel = getIt.get<CartCubit>();
//     super.initState();
//   }
//   @override
//   void dispose() {
//     viewModel.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: viewModel,
//       child: BlocConsumer<CartCubit, CartState>(
//         listener: (context, state) {
//           if (state is CartAddSuccess) {
//
//             Flushbar(
//               message: "تمت إضافة المنتج إلى السلة",
//               icon: const Icon(
//                 Icons.check_circle,
//                 color: Colors.white,
//               ),
//               duration: const Duration(seconds: 2),
//               backgroundColor: Colors.green,
//               flushbarPosition: FlushbarPosition.TOP,  // عشان تظهر من فوق
//               margin: const EdgeInsets.all(16),
//               borderRadius: BorderRadius.circular(12),
//             ).show(context);
//
//           }
//         },
//         builder: (context, state) {
//           return SizedBox(
//             height: 35,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorManager.primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                 ),
//               ),
//               onPressed: () {
//                 showAuthOrAddToCartDialog(
//                   context,
//                   idProduct: widget.product?.idProduct ?? 0,
//                 );
//               },
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 300),
//                 transitionBuilder:
//                     (child, animation) =>
//                         FadeTransition(opacity: animation, child: child),
//                 child:
//                     state is CartAddLoading
//                         ? Row(
//                           key: const ValueKey("loading"),
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             ),
//                           ],
//                         )
//                         : Row(
//                           key: const ValueKey("button"),
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               Assets.cart,
//                               width: 15,
//                               height: 15,
//                               colorFilter: const ColorFilter.mode(
//                                 ColorManager.white,
//                                 BlendMode.srcIn,
//                               ),
//                             ),
//                             const SizedBox(width: AppSize.s8),
//                             Expanded(
//                               child: AutoSizeText(
//                                 "اضافة للسلة",
//                                 style: getSemiBoldStyle(
//                                   color: ColorManager.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
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
    // حساب أبعاد مرنة بناءً على حجم الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1024;
    final isLargeScreen = screenWidth >= 1024;

    // أبعاد متجاوبة
    final imageHeight = isSmallScreen ? 140.0 : (isMediumScreen ? 160.0 : 180.0);
    final cardPadding = isSmallScreen ? 8.0 : (isMediumScreen ? 10.0 : 12.0);
    final borderRadiusValue = isSmallScreen ? 16.0 : (isMediumScreen ? 18.0 : 20.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          clipBehavior: Clip.antiAlias,
          animationDuration: Duration(milliseconds: 500),
          borderRadius: BorderRadius.circular(borderRadiusValue),
          elevation: 0,
          shadowColor: Colors.black.withOpacity(0.08),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadiusValue),
            onTap: () {
              AnalyticsHelper.sendProductVisit(productId: product?.idProduct ?? 0);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(product: product ?? ProductsRelations()),
                ),
              );
            },
            child: Hero(
              tag: '${product?.idProduct}0',
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    border: Border.all(
                      color: Color(0xffE8ECF4),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: Offset(0, 3),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 8,
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                  // صورة المنتج مع الخصم
                  Stack(
                  children: [
                  // الصورة
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    margin: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      color: Color(0xffF8F9FD),
                      borderRadius: BorderRadius.circular(borderRadiusValue - 4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadiusValue - 4),
                      child: CustomImage(
                        url: product?.imageCover ?? '',
                      ),
                    ),
                  ),

                  // شارة الخصم
                  if (product?.productPriceAfterDiscount != 0)
              Positioned(
              top: cardPadding / 2,
              right: cardPadding / 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffFF3B5C),
                      Color(0xffFF6B88),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffFF3B5C).withOpacity(0.35),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 8 : 10,
                  vertical: isSmallScreen ? 5 : 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_offer_rounded,
                      color: Colors.white,
                      size: isSmallScreen ? 12 : 14,
                    ),
                    SizedBox(width: 3),
                    AutoSizeText(
                      "${product?.descount}%",
                      minFontSize: 10,
                      maxFontSize: 13,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 11 : 13,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ],
          ),

          // معلومات المنتج
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                cardPadding + 4,
                0,
                cardPadding + 4,
                cardPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // اسم المنتج
                  AutoSizeText(
                    product?.productName ?? "????",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 15,
                    style: TextStyle(
                      color: Color(0xff1A1D1F),
                      fontSize: isSmallScreen ? 13 : 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: 3),

                  // الوصف
                  AutoSizeText(
                    product?.description ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    minFontSize: 10,
                    maxFontSize: 12,
                    style: TextStyle(
                      color: Color(0xff6F767E),
                      fontSize: isSmallScreen ? 11 : 12,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 8 : 10),

                  // السعر
                  Flexible(
                    child: Row(
                      children: [
                        // السعر الحالي
                        Flexible(
                          child: AutoSizeText(
                            product?.productPriceAfterDiscount != 0
                                ? product?.productPriceAfterDiscount.toString() ?? ''
                                : product?.productPrice.toString() ?? '',
                            maxLines: 1,
                            minFontSize: 14,
                            maxFontSize: 18,
                            style: TextStyle(
                              color: Color(0xffFF3B5C),
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                              height: 1.2,
                            ),
                          ),
                        ),

                        SizedBox(width: 6),

                        // السعر القديم
                        if (product?.productPriceAfterDiscount != 0)
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 5 : 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffF8F9FD),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: AutoSizeText(
                                product?.productPrice.toString() ?? '',
                                maxLines: 1,
                                minFontSize: 9,
                                maxFontSize: 12,
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color(0xff9CA4AB),
                                  color: Color(0xff9CA4AB),
                                  fontSize: isSmallScreen ? 10 : 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 8 : 10),
                ],
              ),
            ),
          ),

          // زر الإضافة للسلة
          ButtonAddToCart(
            product: product,
            isSmallScreen: isSmallScreen,
            borderRadius: borderRadiusValue,
            cardPadding: cardPadding,
          ),
          ],
        ),
        ),
        ),
        ),
        );
      },
    );
  }
}

class ButtonAddToCart extends StatefulWidget {
  const ButtonAddToCart({
    super.key,
    required this.product,
    required this.isSmallScreen,
    required this.borderRadius,
    required this.cardPadding,
  });

  final ProductsRelations? product;
  final bool isSmallScreen;
  final double borderRadius;
  final double cardPadding;

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
    final buttonHeight = widget.isSmallScreen ? 46.0 : 52.0;
    final iconSize = widget.isSmallScreen ? 14.0 : 16.0;
    final fontSize = widget.isSmallScreen ? 13.0 : 15.0;

    return BlocProvider.value(
      value: viewModel,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartAddSuccess) {
            Flushbar(
              message: "تمت إضافة المنتج إلى السلة",
              icon: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Color(0xff34C759),
              flushbarPosition: FlushbarPosition.TOP,
              margin: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(16),
              boxShadows: [
                BoxShadow(
                  color: Color(0xff34C759).withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ).show(context);
          }
        },
        builder: (context, state) {
          return Container(
            height: buttonHeight,
            margin: EdgeInsets.all(widget.cardPadding),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.primaryColor,
                  ColorManager.primaryColor.withOpacity(0.85),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius - 6),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.primaryColor.withOpacity(0.25),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.borderRadius - 6),
                onTap: () {
                  showAuthOrAddToCartDialog(
                    context,
                    idProduct: widget.product?.idProduct ?? 0,
                  );
                },
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        ),
                      ),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ),
                    child: state is CartAddLoading
                        ? Row(
                      key: const ValueKey("loading"),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: widget.isSmallScreen ? 20 : 22,
                          height: widget.isSmallScreen ? 20 : 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      key: const ValueKey("button"),
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(widget.isSmallScreen ? 5 : 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SvgPicture.asset(
                            Assets.cart,
                            width: iconSize,
                            height: iconSize,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AutoSizeText(
                          "اضافة للسلة",
                          minFontSize: 11,
                          maxFontSize: fontSize,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}