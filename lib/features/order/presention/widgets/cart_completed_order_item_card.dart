import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/order/data/models/response/get_active_orders_dto.dart';
import 'package:manarat_amjad/features/order/presention/widgets/order_details.dart';
import 'package:flutter/material.dart';

class CartCompletedOrderItemCard extends StatefulWidget {
  const CartCompletedOrderItemCard({
    super.key,
    required this.index,
    required this.cartItem,
  });

  final int index;
  final ActiveOrder cartItem;

  @override
  State<CartCompletedOrderItemCard> createState() =>
      _CartCompletedOrderItemCardState();
}

class _CartCompletedOrderItemCardState
    extends State<CartCompletedOrderItemCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
      child: Card(
        color: ColorManager.white.withAlpha(240),
        // elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),

          splashColor: ColorManager.primaryColor.withAlpha(200),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetails(order: widget.cartItem),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(8),
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'تاريخ الطلب',
                        style: getSemiBoldStyle(
                          color: ColorManager.indigoDark2,
                          fontSize: 14,
                        ),
                      ),
                      const TextSpan(
                        text: ' : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      TextSpan(
                        text: '${widget.cartItem.createdAt?.split(' ')[0]}',
                        style: getSemiBoldStyle(
                          color: ColorManager.primaryColor,
                          fontSize: 14,
                        ), // أو لون مختلف
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4F8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: Text(
                        widget.cartItem.orderNumber ?? '',
                        style: getSemiBoldStyle(
                          color: ColorManager.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Column(
                            children: [
                              AutoSizeText(
                                "عدد المنتجات",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 14,
                                ),
                              ),
                              AutoSizeText(
                                '${widget.cartItem.orderItems?.length}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.black,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              AutoSizeText(
                                "مبلغ الطلب",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${widget.cartItem.totalPrice?.toStringAsFixed(2)}',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  RialIcon(color: ColorManager.black, size: 10),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              AutoSizeText(
                                "حالة الطلب",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 14,
                                ),
                              ),

                              AutoSizeText(
                                widget.cartItem.status ?? '',
                                style: getSemiBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
