import 'package:fada_alhalij_web/core/di/di.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/features/auth/presentation/pages/auth_screen.dart';
import 'package:fada_alhalij_web/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<bool> isUserLoggedIn() async {
  final userId = await CacheService.getData(key: CacheKeys.userId);
  print("User ID: $userId (${userId.runtimeType})");

  if (userId == null) {
    return false;
  }

  if (userId is String) {
    return userId.isNotEmpty && userId != "0";
  } else if (userId is int) {
    return userId > 0;
  }

  return false;
}

Future<void> executeIfLoggedIn({
  required BuildContext context,
  required Future<void> Function() onLoggedIn,
  required Future<void> Function() onNotLoggedIn,
}) async {
  final isLoggedIn = await isUserLoggedIn();

  if (isLoggedIn) {
    await onNotLoggedIn();
  } else {
    await onLoggedIn();
  }
}

void showAuthOrAddToCartDialog(BuildContext context, {int? idProduct}) async {
  await executeIfLoggedIn(
    context: context,
    onLoggedIn: () async {
      print("User is logged in. Showing signup dialog.");

       Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>  AuthScreen(),
        ),
      ).then((value) {
        if (value==true) {
          if(context.mounted){
            CartCubit.get(context).getCart();
          }

        }
      });
    },
    onNotLoggedIn: () async {
      if (idProduct != null) {

        context.read<CartCubit>().addToCart(idProduct: idProduct);
      }

      print("User not logged in. Adding product to cart or another action.");
    },
  );
}
