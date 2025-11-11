
import 'package:manarat_amjad/features/auth/data/models/responses/auth_signup_response_dto.dart';
import 'package:manarat_amjad/features/auth/data/models/responses/auth_singin_response_dto.dart';

class AuthSignupEntity {

  final String? status;

  final User? user;

  AuthSignupEntity ({
    this.status,
    this.user,
  });

}

class AuthSingInEntity {

  final String? status;

  final String? message;

  final UserSignin? user;

  AuthSingInEntity ({
    this.status,
    this.message,
    this.user,
  });


}

class EditProfileEntity {

  final bool? status;

  final String? message;

  EditProfileEntity ({
    this.status,
    this.message,
  });


}