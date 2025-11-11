import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/functions/is_user_logged_in.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/core/widgets/custom_empty.dart';
import 'package:manarat_amjad/features/order/data/models/response/get_active_orders_dto.dart';
import 'package:manarat_amjad/features/order/presention/cubit/active_orders_cubit/active_orders_cubit.dart';
import 'package:manarat_amjad/features/order/presention/widgets/cart_active_order_item_card.dart';
import 'package:manarat_amjad/features/order/presention/widgets/cart_completed_order_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedOrdersView extends StatefulWidget {
  const CompletedOrdersView({super.key});

  @override
  State<CompletedOrdersView> createState() => _CompletedOrdersViewState();
}

class _CompletedOrdersViewState extends State<CompletedOrdersView> {
  late ActiveOrdersCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ActiveOrdersCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel..getCompletedOrder(),
      child: BlocConsumer<ActiveOrdersCubit, ActiveOrdersState>(
        listener: (context, state) {
          if (state is OrdersCompletedFail) {
            // CustomDialog.showErrorDialog(context, message: state.exception.toString());
          }
        },
        builder: (context, state) {
          if (state is OrdersCompletedSuccess) {
            List<ActiveOrder>? cartItems =
                state.getActiveOrdersEntity.orders ?? [];

            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 8,
                            left: 8,
                            bottom: 65,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                itemBuilder: (context, index) {
                                  return CartCompletedOrderItemCard(
                                    index: index,
                                    cartItem: cartItems[index],
                                  );
                                },
                                itemCount: cartItems.length,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is OrdersCompletedFail) {
            if (isActiveUser) {
              return CustomEmpty(
                text: ' لا يوجد طلبات سابقة',
                activeButton: false,
              );
            } else {
              return CustomEmpty(
                text: 'قم بالتسجيل الدخول للمتابعة',
                textButton: "تسجيل دخول",
                onTap: () {
                  showAuthOrAddToCartDialog(context);
                },
              );
            }
          }

          return SizedBox();
        },
      ),
    );
  }
}
