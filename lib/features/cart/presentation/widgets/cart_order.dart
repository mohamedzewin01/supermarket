import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/cart/data/models/response/cart_dto.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:manarat_amjad/features/cart/presentation/widgets/cart_order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartOrder extends StatefulWidget {
  const CartOrder({super.key});

  @override
  State<CartOrder> createState() => _CartOrderState();
}

class _CartOrderState extends State<CartOrder> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // Handle listener logic here
      },
      builder: (context, state) {
        if (state is CartSuccess) {
          List<CartItems>? cartItems = state.cartEntity?.cart?.cartItems ??
              [];
          Cart? myCart=state.cartEntity?.cart;
          return SliverToBoxAdapter(
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
                          style: getSemiBoldStyle(color: ColorManager.indigoDark2,fontSize: 14),
                        ),
                        TextSpan(
                          text: '${cartItems.length}',
                          style: getSemiBoldStyle(color: ColorManager.primaryColor,fontSize: 14), // أو لون مختلف
                        ),
                      ],
                    ),
                  ),
                  Container(height: 2,width: 80,color: ColorManager.indigoDark2 ,),
                  SizedBox(height: 8,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    itemBuilder:(context, index) {
                      return  CartOrderItemCard(
                        index: index,
                        cartItem: cartItems[index],
                      );
                    },
                    itemCount: cartItems.length,

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
                                    'المبلغ قبل الخصم:',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.lightTextColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),

                                Text(
                                  myCart?.totalPrice?.toStringAsFixed(2)??'',
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
                                Expanded(
                                  child: Text(
                                    'الخصم:',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.lightTextColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  myCart?.totalDiscount?.toStringAsFixed(2)??'',
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
                                Expanded(
                                  child: Text(
                                    'السعر النهائي:',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.lightTextColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  myCart?.finalPrice?.toStringAsFixed(2)??'',
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

                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

        }


        return SliverToBoxAdapter(
          child: SizedBox(),
        );
      },
    );
  }
}