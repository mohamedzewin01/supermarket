import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/auth/data/models/request/auth_signin_request.dart';
import 'package:manarat_amjad/features/auth/data/models/request/auth_signup_request.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:manarat_amjad/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthUseCase  {
  final AuthRepo _authRepo;

  AuthUseCase(this._authRepo);


  Future<Result<AuthSignupEntity?>> signup(
    AuthSignupRequest authSignupRequest,
  ) => _authRepo.signup(authSignupRequest);


  Future<Result<AuthSingInEntity?>> signIn(
    AuthSignInRequest authSignInRequest,
  ) => _authRepo.signIn(authSignInRequest);



}
