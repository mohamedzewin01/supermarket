
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:manarat_amjad/features/cart/presentation/widgets/check_out.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({super.key, required this.viewModel});

  final CartCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      fillOverscroll: true,
      hasScrollBody: false,
      child: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.symmetric(
          //     vertical: 8.0,
          //     horizontal: 16,
          //   ),
          //   padding: EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: Colors.blue.shade50,
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(color: Colors.blue),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: const [
          //       Icon(Icons.local_offer, color: Colors.blue),
          //       SizedBox(width: 8),
          //       Text(
          //         'احصل على خصم عند الشراء فوق 100 ريال!',
          //         style: TextStyle(
          //           color: Colors.blue,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // المساحة الفارغة لملء الارتفاع المتبقي
          Spacer(),
          Divider(color: Colors.grey.shade300),
          // العناصر التي تظهر في الأسفل
          Container(
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
              left: 16.0,
              bottom: 65,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'المبلغ قبل الخصم:',
                      style: getSemiBoldStyle(
                        color: ColorManager.lightTextColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      viewModel.myCart!.totalPrice!.toStringAsFixed(2),
                      style: getSemiBoldStyle(
                        color: ColorManager.lightTextColor,
                        fontSize: 16,
                      ),
                    ),
                    RialIcon(color: ColorManager.darkTextColor, size: 14),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الخصم:',
                      style: getSemiBoldStyle(
                        color: ColorManager.lightTextColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      viewModel.myCart!.totalDiscount!.toStringAsFixed(2),
                      style: getSemiBoldStyle(
                        color: ColorManager.lightTextColor,
                        fontSize: 16,
                      ),
                    ),
                    RialIcon(color: ColorManager.darkTextColor, size: 14),
                  ],
                ),
                SizedBox(height: 8),
                Divider(color: Colors.grey.shade300),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'السعر النهائي:',
                      style: getSemiBoldStyle(
                        color: ColorManager.lightTextColor,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      viewModel.myCart!.finalPrice!.toStringAsFixed(2),
                      style: TextStyle(
                        color: ColorManager.darkTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RialIcon(),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOut()),
                    ).then((value) {
                      viewModel.getCart(); // تحديث السلة
                      if (CartCubit.get(context).shouldGoToTab1) {
                        CartCubit.get(context).tabController.animateTo(1);
                        CartCubit.get(context).shouldGoToTab1 = false; // إعادة تعيين بعد الاستخدام
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          'المتابعة لإتمام الشراء',
                          style: getSemiBoldStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
