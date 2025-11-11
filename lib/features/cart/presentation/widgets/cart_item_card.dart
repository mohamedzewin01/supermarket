import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({super.key, required this.index, required this.viewModel});

  final CartCubit viewModel;
  final int index;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    var product = widget.viewModel.cartItems[widget.index].product;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                    url: product?.imgCover ?? '',
                    width: 50,
                    height: 50,
                  ),
                ),
                if (product?.discount != 0)
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
                    product?.title ?? '',
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
                        '${product?.priceAfterDiscount?.toStringAsFixed(2)}',
                        style: getSemiBoldStyle(
                          color: ColorManager.black,
                          fontSize: 14,
                        ),
                      ),
                      RialIcon(color: ColorManager.black, size: 10),
                      if (widget
                              .viewModel
                              .cartItems[widget.index]
                              .product
                              ?.discount !=
                          0) ...[
                        Spacer(),
                        Text(
                          '${product?.price?.toStringAsFixed(2)}',
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

            // Quantity Selector
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    await widget.viewModel.decreaseQuantity(
                      productId: product!.id!,
                      index: widget.index,
                    );

                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorManager.primaryColor),
                      color: ColorManager.primaryColor,
                    ),
                    child: Icon(
                      Icons.remove,
                      size: 18,
                      color: ColorManager.white,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: Text(
                    '${widget.viewModel.cartItems[widget.index].quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primaryColor,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () async {
                    await widget.viewModel.increaseQuantity(
                      productId: product!.id!,
                      index: widget.index,
                    );
                    setState(() {});
                  },
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorManager.primaryColor),
                      color: ColorManager.primaryColor,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 18,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
