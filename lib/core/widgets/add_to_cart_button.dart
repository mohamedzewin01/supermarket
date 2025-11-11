import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/values_manager.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';


class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.productId,
  });
  final int productId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartAddSuccess) {
          // showSuccessToast(
          //   context: context,
          //   message: AppLocalizations.of(context)!.addedToCartSuccess,
          //   title: AppLocalizations.of(context)!.done,
          // );
        } else if (state is CartAddFail) {
          // final String message;
          // if (CacheConstants.userToken == '') {
          //   message = AppLocalizations.of(context)!.loginToPurchase;
          // } else {
          //   message = AppLocalizations.of(context)!.loginToPurchase;
          // }
          // return showErrorToast(
          //   context: context,
          //   message: message,
          // );
        }
      },
      builder: (context, state) {
        return state is CartAddLoading
            ? const SizedBox(
                height: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LinearProgressIndicator(
                    color: ColorManager.primaryColor,
                  ),
                ),
              )
            : SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                    ),
                  ),
                  onPressed: () async {

                    await CartCubit.get(context).addToCart(idProduct: productId);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.cart,
                        width: 15,
                        height: 15,
                        colorFilter: const ColorFilter.mode(
                          ColorManager.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      Text(
                       "اضافة للسلة",
                        style: const TextStyle().copyWith(
                          color: ColorManager.white,
                          fontSize: AppSize.s12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
