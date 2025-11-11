import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/auth/data/data_sources/auth_data_sources_repo.dart';
import 'package:manarat_amjad/features/auth/data/models/request/auth_signin_request.dart';
import 'package:manarat_amjad/features/auth/data/models/request/auth_signup_request.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:manarat_amjad/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSourcesRepo authDataSourcesRepo;

  AuthRepoImpl(this.authDataSourcesRepo);

  @override
  Future<Result<AuthSignupEntity?>> signup(
    AuthSignupRequest authSignupRequest,
  ) {
    return authDataSourcesRepo.signup(authSignupRequest);
  }

  @override
  Future<Result<AuthSingInEntity?>> signIn(
    AuthSignInRequest authSignInRequest,
  ) {
    return authDataSourcesRepo.signIn(authSignInRequest);
  }


}
