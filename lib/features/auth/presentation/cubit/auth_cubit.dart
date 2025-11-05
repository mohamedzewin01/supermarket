import 'package:bloc/bloc.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/features/auth/data/models/request/auth_signin_request.dart';
import 'package:fada_alhalij_web/features/auth/data/models/request/auth_signup_request.dart';
import 'package:fada_alhalij_web/features/auth/data/models/request/edit_profile_request.dart';
import 'package:fada_alhalij_web/features/auth/data/models/responses/auth_singin_response_dto.dart';
import 'package:fada_alhalij_web/features/auth/domain/entities/auth_entities.dart';
import 'package:fada_alhalij_web/features/auth/domain/use_cases/auth_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authUseCase) : super(AuthInitial());
  final AuthUseCase _authUseCase;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordSignInController = TextEditingController();

  Future<void> signIn() async {
    emit(AuthSignInLoading());
    AuthSignInRequest authSignInRequest = AuthSignInRequest(
      login: loginController.text,
      password: passwordSignInController.text,
    );
    var result = await _authUseCase.signIn(authSignInRequest);
    switch (result) {
      case Success<AuthSingInEntity?>():
        {
          if (!isClosed) {
            await CacheService.setData(
              key: CacheKeys.userId,
              value: result.data?.user?.id,
            );
            await CacheService.setData(
              key: CacheKeys.userName,
              value: result.data?.user?.username,
            );
            await CacheService.setData(
              key: CacheKeys.userEmail,
              value: result.data?.user?.email,
            );
            await CacheService.setData(
              key: CacheKeys.userPhone,
              value: result.data?.user?.phone,
            );
            await CacheService.setData(
              key: CacheKeys.isActive,
              value: true,
            );

            emit(AuthSignInSuccess(result.data!));
          }
        }
      case Fail<AuthSingInEntity?>():
        {
          emit(AuthSignInFail(result.exception));
        }
    }
  }

  Future<void> signUp() async {
    emit(AuthSignUpLoading());
    AuthSignupRequest authSignupRequest = AuthSignupRequest(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
      gender: "male",
      rePassword: rePasswordController.text,
      phone: phoneController.text,
    );
    var result = await _authUseCase.signup(authSignupRequest);

    switch (result) {
      case Success<AuthSignupEntity?>():
        {
          if (!isClosed) {
            await CacheService.setData(
              key: CacheKeys.userId,
              value: result.data?.user?.id,
            );
            await CacheService.setData(
              key: CacheKeys.userName,
              value: result.data?.user?.name,
            );
            await CacheService.setData(
              key: CacheKeys.userEmail,
              value: result.data?.user?.email,
            );
            await CacheService.setData(
              key: CacheKeys.userPhone,
              value: result.data?.user?.phone,
            );
            await CacheService.setData(
              key: CacheKeys.isActive,
              value: true,
            );
            emit(AuthSignUpSuccess(result.data!));
          }
        }
      case Fail<AuthSignupEntity?>():
        {
          emit(AuthSignUpFail(result.exception));
        }
    }
  }




}
