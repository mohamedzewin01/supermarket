import 'package:manarat_amjad/core/api/api_extentions.dart';
import 'package:manarat_amjad/core/api/api_manager/api_manager.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/auth/data/models/request/auth_signin_request.dart';

import 'package:manarat_amjad/features/auth/data/models/request/auth_signup_request.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';

import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:injectable/injectable.dart';

import 'auth_data_sources_repo.dart';

@Injectable(as: AuthDataSourcesRepo)
class AuthDataSourcesRpoImpl implements AuthDataSourcesRepo {
  final ApiService _apiService;

  AuthDataSourcesRpoImpl(this._apiService);

  @override
  Future<Result<AuthSignupEntity?>> signup(
    AuthSignupRequest authSignupRequest,
  ) {
    return executeApi(() async {
      var response = await _apiService.signUp(authSignupRequest);
      return response?.toAuthSignupEntity();
    });
  }

  @override
  Future<Result<AuthSingInEntity?>> signIn(AuthSignInRequest authSignInRequest) {
    return executeApi(() async {
      var response = await _apiService.signIn(authSignInRequest);
      return response?.toAuthSingInEntity();
    });
  }


}
