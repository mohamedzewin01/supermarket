import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.orderNumber,
    required this.orderDate,
    required this.itemsCount,
    required this.totalAmount,
  });

  final String orderNumber;
  final String orderDate;
  final int itemsCount;
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رقم الاوردر  $orderNumber',
                  // textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  DateFormat(
                    'EEEE d MMMM - HH:mm a',
                    'ar',
                  ).format(DateTime.parse(orderDate)),
                  style: getSemiBoldStyle(color: ColorManager.black),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      ' عدد المنتجات : $itemsCount',
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'اجمالي المبلغ : $totalAmount',
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 16),
          ClipOval(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.primary3,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],

              ),

              child: Center(
                child: SvgPicture.asset(
                  Assets.orderSvg,
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    ColorManager.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          )

          // Order Details
        ],
      ),
    );
  }
}
