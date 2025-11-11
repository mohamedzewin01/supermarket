import 'package:manarat_amjad/core/common/custom_exception.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';

import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/core/widgets/custom_sliver_app_bar.dart';
import 'package:manarat_amjad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:manarat_amjad/features/auth/presentation/widgets/signIn_form_view.dart';
import 'package:manarat_amjad/features/auth/presentation/widgets/signup_form_view.dart';
import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:manarat_amjad/localization/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthCubit viewModel;
  bool isLogin = true;

  @override
  void initState() {
    viewModel = getIt.get<AuthCubit>();
    super.initState();
  }

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => viewModel,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSignInSuccess) {
                isActiveUser = true;
                CustomDialog.showSuccessDialog(
                  context,
                  message: "تم تسجيل الدخول بنجاح",
                );
              }

              if (state is AuthSignUpSuccess) {
                isActiveUser = true;

                CustomDialog.showSuccessDialog(
                  context,
                  message: "تم تسجيل الدخول بنجاح",
                );
              }
              if (state is AuthSignUpLoading) {
                CustomDialog.showLoadingDialog(context);
              }
              if (state is AuthSignUpFail) {
                Navigator.pop(context);
                String message;
                if (state.exception is ServerError) {
                  message =
                      (state.exception as ServerError).serverMessage ?? '';
                } else {
                  message = 'somethingWentWrong';
                }
                CustomDialog.showErrorDialog(context, message: message);
              }
              if (state is AuthSignInFail) {
                String message;
                if (state.exception is ServerError) {
                  message =
                      (state.exception as ServerError).serverMessage ?? '';
                } else {
                  message = 'somethingWentWrong';
                }
                CustomDialog.showErrorDialog(context, message: message);
              }
            },
            child: CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  title: 'تسجيل الدخول',
                  isBack: false,

                  onBackTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                  spacing: 16,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor,
                            shape: BoxShape.circle,
                          ),

                          child: Image.asset(
                            Assets.logo3,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        SizedBox(height: 16),
                        isLogin
                            ? SignInForm(viewModel: viewModel)
                            : SignupForm(viewModel: viewModel),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isLogin ? "ليس لديك حساب؟" : "لديك حساب؟",
                              style: getSemiBoldStyle(
                                color: ColorManager.primary,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: toggleAuthMode,
                              child: Text(
                                isLogin ? "سجل الآن" : "تسجيل الدخول",
                                style: getSemiBoldStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
