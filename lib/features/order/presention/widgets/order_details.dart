import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/order/data/models/response/get_active_orders_dto.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.order});

  final ActiveOrder order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.indigoDark2,
              elevation: 10,
              pinned: false,
              floating: true,
              snap: true,
              title: Text(
                'تفاصيل الطلب',
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: 20,
                ),
              ),
              leading:InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 10,
                  width: 10,
                  padding: EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'عدد المنتجات: ',
                              style: getSemiBoldStyle(
                                color: ColorManager.indigoDark2,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: '${order.orderItems?.length}',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryColor,
                                fontSize: 14,
                              ), // أو لون مختلف
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 80,
                        color: ColorManager.indigoDark2,
                      ),
                      SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemBuilder: (context, index) {
                          return OrderDetailsItemCard(
                            index: index,
                            cartItem: order.orderItems![index],
                          );
                        },
                        itemCount: order.orderItems?.length,
                      ),
                      Column(
                        children: [
                          Divider(color: Colors.grey.shade300),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'المبلغ الاجمالي:',
                                        style: getSemiBoldStyle(
                                          color: ColorManager.lightTextColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),

                                    Text(
                                      order.totalPrice?.toStringAsFixed(2) ?? '',
                                      style: getSemiBoldStyle(
                                        color: ColorManager.lightTextColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                    RialIcon(
                                      color: ColorManager.darkTextColor,
                                      size: 14,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8),
                                Divider(color: Colors.grey.shade300),

                                SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}

class OrderDetailsItemCard extends StatefulWidget {
  const OrderDetailsItemCard({
    super.key,
    required this.index,
    required this.cartItem,
  });

  final int index;
  final OrderItems cartItem;

  @override
  State<OrderDetailsItemCard> createState() => _OrderDetailsItemCardState();
}

class _OrderDetailsItemCardState extends State<OrderDetailsItemCard> {
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
                    url: widget.cartItem.imgCover ?? '',
                    width: 40,
                    height: 40,
                  ),
                ),
                if (widget.cartItem.discount != 0)
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
                    widget.cartItem.title ?? '',
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
                        widget.cartItem.discount != 0
                            ? '${widget.cartItem.priceAfterDiscount?.toStringAsFixed(2)}'
                            : '${widget.cartItem.price?.toStringAsFixed(2)}',
                        style: getSemiBoldStyle(
                          color: ColorManager.black,
                          fontSize: 14,
                        ),
                      ),
                      RialIcon(color: ColorManager.black, size: 10),
                      if (widget.cartItem.discount != 0) ...[
                        Spacer(),
                        Text(
                          '${widget.cartItem.price?.toStringAsFixed(2)}',
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
                        '${widget.cartItem.totalPrice?.toStringAsFixed(2)}',
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
