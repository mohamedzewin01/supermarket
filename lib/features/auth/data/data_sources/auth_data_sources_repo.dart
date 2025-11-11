
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/auth/data/models/request/auth_signin_request.dart';
import 'package:manarat_amjad/features/auth/data/models/request/auth_signup_request.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';

abstract class AuthDataSourcesRepo {
  Future<Result<AuthSignupEntity?>> signup(AuthSignupRequest authSignupRequest);
  Future<Result<AuthSingInEntity?>> signIn(AuthSignInRequest authSignInRequest);

}