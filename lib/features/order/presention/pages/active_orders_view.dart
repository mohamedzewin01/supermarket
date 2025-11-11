import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/api/model/order_firebase_model.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/functions/is_user_logged_in.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/core/utils/constants.dart';
import 'package:manarat_amjad/core/utils/firebase_utils.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/core/widgets/custom_empty.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/cart/presentation/widgets/cart_order_item_card.dart';
import 'package:manarat_amjad/features/order/data/models/response/get_active_orders_dto.dart';
import 'package:manarat_amjad/features/order/presention/cubit/active_orders_cubit/active_orders_cubit.dart';
import 'package:manarat_amjad/features/order/presention/widgets/cart_active_order_item_card.dart';
import 'package:manarat_amjad/features/order/presention/widgets/order_details.dart';
import 'package:manarat_amjad/features/order/presention/widgets/order_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ActiveOrderView extends StatefulWidget {
  const ActiveOrderView({super.key});

  @override
  State<ActiveOrderView> createState() => _ActiveOrderViewState();
}

class _ActiveOrderViewState extends State<ActiveOrderView> {
  late ActiveOrdersCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ActiveOrdersCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel..getActiveOrders(),
      child: BlocConsumer<ActiveOrdersCubit, ActiveOrdersState>(
        listener: (context, state) {
          if (state is OrdersActiveFail) {
            // CustomDialog.showErrorDialog(context, message: state.exception.toString());
          }
        },
        builder: (context, state) {
          if (state is OrdersActiveSuccess) {
            List<ActiveOrder>? order = state.getActiveOrdersEntity.orders ?? [];
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
                            bottom: 16,
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
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => OrderDetails(
                                                    order: order[index],
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            OrderSummaryCard(
                                              orderNumber:
                                                  order[index].orderNumber ??
                                                  '',
                                              orderDate:
                                                  order[index].createdAt ?? '',
                                              itemsCount:
                                                  order[index]
                                                      .orderItems
                                                      ?.length ??
                                                  0,
                                              totalAmount:
                                                  order[index].totalPrice ?? 0,
                                            ),
                                            SizedBox(height: 16),
                                            TrackOrder(
                                              idOrder:
                                                  order[index].idOrder ?? 0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                itemCount: order.length,
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
          if (state is OrdersActiveFail) {
            if (isActiveUser) {
              return CustomEmpty(
                text: ' لا يوجد طلبات نشطة',
                activeButton: false,
              );
            } else {
              return CustomEmpty(
                text: 'قم بالتسجيل الدخول للمتابعة',
                textButton: 'تسجيل دخول',
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

class TrackOrder extends StatelessWidget {
  const TrackOrder({super.key, required this.idOrder});

  final int idOrder;

  @override
  Widget build(BuildContext context) {
    return _buildOrderTimeline();
  }

  Widget _buildOrderTimeline() {


    return StreamBuilder<OrdersFirebaseModel?>(
      stream: FirebaseUtils.getOrders(idOrder: idOrder.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Text(
            "بانتظار قبول الطلب",
            style: getSemiBoldStyle(color: ColorManager.error),
          );
        }

        OrdersFirebaseModel? orderData = snapshot.data;
        String status = orderData?.status ?? 'Pending';
        print(status);
        if (!Constants.orderStages.contains(status)) {
          print("Warning: Unknown order state - $status");
          status = "Order Accepted";
        }

        return Column(
          children:
              Constants.orderStages.map((state) {
                int index = Constants.orderStages.indexOf(state);
                bool isActive = index <= Constants.orderStages.indexOf(status);
                return _buildOrderStatus(
                  acceptedAt:orderData?.acceptedAt ?? '',
                  preparingAt:orderData?.preparingAt ?? '',
                  outDeliveryAt:orderData?.outDeliveryAt ?? '',
                  createdAt:orderData?.createdAt ?? '',
                  status: state,
                  date: orderData?.updatedAt ?? '',
                  index: index,
                  isActive: isActive,
                );
              }).toList(),
        );
      },
    );

  }

  Widget _buildOrderStatus({
    required String status,
    required int index,
    required String date,
    required String acceptedAt,
    required String preparingAt,
    required String outDeliveryAt,
    required String createdAt,
    bool isActive = false,
  }) {
    String getDateForStatus() {
      switch (status) {
        case 'Pending':
          return createdAt;
        case 'Order Accepted':
          return acceptedAt;
        case 'Preparing':
          return preparingAt;
        case 'Out for Delivery':
          return outDeliveryAt;
        default:
          return '';
      }
    }
    final parsedDate = DateTime.tryParse(getDateForStatus());
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isActive
                          ? SizedBox()
                          : SizedBox(
                            height: 10,
                            width: 18,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                                strokeWidth: 1,
                                // padding: EdgeInsets.all(12),
                              ),
                            ),
                          ),

                      Text(
                        Constants.getButtonLabel(status),
                        style: getSemiBoldStyle(

                          color: isActive ? ColorManager.primary : Colors.grey,
                          fontSize: isActive ? 12 : 10,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  parsedDate != null
                      ? DateFormat('EEEE d MMMM - HH:mm a', 'ar').format(parsedDate)
                      : '',

                  style: getSemiBoldStyle(
                    color: isActive ? ColorManager.grey : Colors.white,
                    fontSize: isActive ? 12 : 12,
                  ),
                ),

              ],
            ),
          ),

          Column(
            children: [
              Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? ColorManager.primary3 : Colors.white,
                  border: Border.all(
                    color:
                        isActive
                            ? ColorManager.primary
                            : Colors.grey.withAlpha(200),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Constants.imageOrder[index],
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      isActive
                          ? ColorManager.primary
                          : Colors.grey.withAlpha(200),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),

              if (status != "Delivered")
                Container(
                  width: 2,
                  height: 30,
                  color:
                      isActive
                          ? ColorManager.primary3
                          : Colors.grey.withAlpha(200),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
