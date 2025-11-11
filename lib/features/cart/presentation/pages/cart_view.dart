import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:manarat_amjad/features/cart/presentation/widgets/cart_body.dart';
import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:manarat_amjad/features/order/presention/pages/active_orders_view.dart';
import 'package:manarat_amjad/features/order/presention/pages/completed_orders_view.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skeletonizer/skeletonizer.dart';



class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView>
    with SingleTickerProviderStateMixin {
  late CartCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<CartCubit>();
    viewModel.tabController = TabController(length: 3, vsync: this);
    viewModel.getCart();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value:  viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primaryColor,
            title: Text(
              "السلة",
              style: getSemiBoldStyle(
                color: ColorManager.white,
                fontSize: 14,
              ),
            ),
            actions: [
              Image.asset(Assets.logo3, ),
            ],
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  LayoutCubit.get(context).changeIndex(0);
                },
                child: Container(
                  height: 45,
                  width: 45,
                  padding: EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(

              preferredSize: const Size.fromHeight(35),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: ColorManager.white,
                ),
                child: DefaultTabController(
                  length: 3, // Number of tabs
                  child: TabBar(

                    controller: viewModel.tabController,
                    labelStyle: getSemiBoldStyle(color: ColorManager.primaryColor),
                    tabs: [
                      Tab(text: "السلة",),
                      Tab(text: "الطلبات النشطة"),
                      Tab(text: "الطلبات السابقة"),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: DefaultTabController(
            length: 3, // Number of tabs
            child: TabBarView(
              controller: viewModel.tabController,
              children: [
                CartBody(viewModel: viewModel),
                ActiveOrderView(),
                CompletedOrdersView() ,// Tab for Active Products
                 // Tab for Inactive Products
              ],
            ),
          ),
        ),
      ),
    );
  }
}



