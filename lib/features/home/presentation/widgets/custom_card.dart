import 'dart:ui';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/features/best_deals/presention/widgets/best_deals_by_discount.dart';
import 'package:manarat_amjad/features/home/data/models/response/home_model_response_dto.dart';

import '../../../../core/resources/routes_manager.dart';

import '../../../../core/functions/extenstions.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.discounts});

  final List<Discounts>? discounts;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child:
          discounts!.isNotEmpty
              ? SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      discounts?.length, // Adjust the item count as needed
                  itemBuilder: (context, index) {
                    Discounts discount = discounts![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.sizeOf(context).width,
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black26,
                          color: ColorManager.indigoLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // CustomImage(
                              //   url: discount.imageUrl ?? '',
                              //
                              //   boxFit: BoxFit.cover,
                              // ),
                              Positioned.fill(
                                child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return RadialGradient(
                                      center: Alignment.center,
                                      radius: 0.8,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.6),
                                      ],
                                      stops: const [0.4, 1.0],
                                    ).createShader(rect);
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),
                                    child: Container(color: Colors.transparent),
                                  ),
                                ),
                              ),
                              // Content on top of the blurred card
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.screenWidth * 0.04,
                                    vertical: context.screenHeight * 0.02,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        discount.title ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.s18,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                              color: Colors.black87,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        discount.subtitle ?? '',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: FontSize.s14,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      CustomElevatedButton(
                                        title: "اكتشف العروض",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (
                                                    context,
                                                  ) => BestDealsByDiscountView(
                                                    discount:
                                                        discount
                                                            .discountPercentage,
                                                  ),
                                            ),
                                          );
                                        },
                                        buttonColor: ColorManager.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 20,
                                bottom: 10,
                                child: CustomImage(
                                  url: discount.imageIcon ?? '',
                                  height: 80,
                                  width: 150,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              : SizedBox(),
    );
  }
}
