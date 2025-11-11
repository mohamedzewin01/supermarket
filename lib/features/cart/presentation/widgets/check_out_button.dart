import 'package:manarat_amjad/core/common/custom_exception.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/utilss.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:manarat_amjad/features/order/presention/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutButton extends StatefulWidget {
  const CheckOutButton({super.key, required this.idAddress});

  final int idAddress;

  @override
  State<CheckOutButton> createState() => _CheckOutButtonState();
}

class _CheckOutButtonState extends State<CheckOutButton> {
  late OrdersCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<OrdersCubit>();
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
      child: BlocListener<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is AddOrdersSuccess) {
            CartCubit.get(context).shouldGoToTab1 = true;
            Navigator.pop(context);
            CustomDialog.showSuccessDialog(context,message: 'تم اضافة الطلب بنجاح');
          }
          if(state is AddOrdersFail){

            Navigator.pop(context);
            String message;
            if (state.exception is ServerError) {
              message = (state.exception as ServerError).serverMessage ??
                  '';
            } else {
              message = 'somethingWentWrong';
            }
            CustomDialog.showErrorDialog(context, message: message);
          }
          if(state is AddOrdersLoading){

            CustomDialog.showLoadingDialog(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
            ),

            onPressed: () async {
              print(widget.idAddress);
              if (context.read<CartCubit>().idAddress  == 0) return;
              await viewModel.addOrder(idAddress: context.read<CartCubit>().idAddress ?? 0);
              if (context.mounted) {

              }
            },
            child: Text(
              'تأكيد الشراء',
              style: getSemiBoldStyle(color: ColorManager.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}