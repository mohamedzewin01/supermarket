import 'package:another_flushbar/flushbar.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/functions/is_user_logged_in.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';

import 'package:manarat_amjad/features/products/data/models/response/get_products_by_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonAddToCartDetails extends StatefulWidget {
  const ButtonAddToCartDetails({super.key, required this.product});

  final ProductsRelations? product;

  @override
  State<ButtonAddToCartDetails> createState() => _ButtonAddToCartDetailsState();
}

class _ButtonAddToCartDetailsState extends State<ButtonAddToCartDetails> {
  late CartCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<CartCubit>();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartAddSuccess) {
            Flushbar(
              message: "تمت إضافة المنتج إلى السلة",
              icon: const Icon(Icons.check_circle, color: Colors.white),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
              flushbarPosition: FlushbarPosition.TOP,
              // عشان تظهر من فوق
              margin: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(12),
            ).show(context);
          }
        },
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              showAuthOrAddToCartDialog(
                context,
                idProduct: widget.product?.idProduct ?? 0,
              );
            },
            icon: Container(
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.all(4),

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.primaryColor,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder:
                    (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child:
                state is CartAddLoading
                    ? const SizedBox(
                  key: ValueKey("loading"),
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Icon(size: 20, Icons.add, color: ColorManager.white),
              ),
            ),
          );
        },
      ),
    );
  }
}