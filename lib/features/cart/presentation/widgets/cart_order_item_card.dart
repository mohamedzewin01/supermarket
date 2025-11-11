
import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/cart/data/models/response/cart_dto.dart';
import 'package:flutter/material.dart';

class CartOrderItemCard extends StatefulWidget {
  const CartOrderItemCard({
    super.key,
    required this.index,
    required this.cartItem,
  });

  final int index;
  final CartItems cartItem;

  @override
  State<CartOrderItemCard> createState() => _CartOrderItemCardState();
}

class _CartOrderItemCardState extends State<CartOrderItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4F8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: CustomImage(
                    url: widget.cartItem.product?.imgCover ?? '',
                    width: 40,
                    height: 40,
                  ),
                ),
                if (widget.cartItem.product?.discount != 0)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.error.withAlpha(230),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'عرض خاص',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    widget.cartItem.product?.title ?? '',
                    style: getSemiBoldStyle(
                      color: ColorManager.black,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '${widget.cartItem.product?.priceAfterDiscount
                            ?.toStringAsFixed(2)}',
                        style: getSemiBoldStyle(
                          color: ColorManager.black,
                          fontSize: 14,
                        ),
                      ),
                      RialIcon(color: ColorManager.black, size: 10),
                      if (widget.cartItem.product?.discount != 0) ...[
                        Spacer(),
                        Text(
                          '${widget.cartItem.product?.price?.toStringAsFixed(
                              2)}',
                          style: getSemiBoldStyle(
                            color: ColorManager.error,
                            fontSize: 12,
                          ).copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: ColorManager.error,
                            decorationThickness: 2,
                            height: 1.5,
                          ),
                        ),

                        RialIcon(color: ColorManager.error, size: 10),
                        Spacer(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    AutoSizeText(
                      "الكمية",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 6.0,
                      ),
                      child: AutoSizeText(
                        '${widget.cartItem.quantity}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),

                Column(
                  children: [
                    AutoSizeText(
                      "اجمالي",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 6.0,
                      ),
                      child: AutoSizeText(
                        '${widget.cartItem
                            .totleProductPriceAfterDiscount?.toStringAsFixed(
                            2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}