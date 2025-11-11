import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/functions/is_user_logged_in.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/cashed_image.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/core/widgets/custom_empty.dart';
import 'package:manarat_amjad/features/cart/data/models/response/cart_dto.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:manarat_amjad/features/cart/presentation/widgets/cart_items_list_section.dart';
import 'package:manarat_amjad/features/cart/presentation/widgets/cart_summary_section.dart';
import 'package:manarat_amjad/features/cart/presentation/widgets/skeletonizer_cart.dart';
import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:manarat_amjad/localization/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key, required this.viewModel});

  final CartCubit viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if(state is CartFail) {
              // CustomDialog.showErrorDialog(context, message: state.exception.toString());
            }
          },
          builder: (context, state) {
            viewModel.cartItems.clear();
            if (state is CartSuccess) {
              List<CartItems>? cartItems =
                  state.cartEntity?.cart?.cartItems ?? [];
              viewModel.cartItems.addAll(cartItems);
              viewModel.myCart = state.cartEntity?.cart?.copyWith(
                finalPrice: state.cartEntity?.cart?.finalPrice,
              );
              return cartItems.isNotEmpty
                  ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomScrollView(
                        slivers: [
                          CartItemsListSection(viewModel: viewModel),
                          CartSummarySection(viewModel: viewModel),
                        ],
                      ),
                    ),
                  )
                  : CustomEmpty(
                    text: 'لا يوجد عناصر في السلة',
                    textButton: 'تسوق الان',
                    onTap: () {
                      LayoutCubit.get(context).changeIndex(0);
                    },
                  );

            }
            if (state is CartLoading) {
              return SkeCart();
            }
            if (state is CartFail) {
              if (isActiveUser) {
                return CustomEmpty(
                  onTap: () {
                    LayoutCubit.get(context).changeIndex(0);
                  },
                  text: 'السله فارغة',
                  textButton: 'تسوق الان',
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
            return CircularProgressIndicator(color: ColorManager.primaryColor);
          },
        ),
      ],
    );
  }
}
