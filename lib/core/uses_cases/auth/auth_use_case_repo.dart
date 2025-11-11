

import 'package:manarat_amjad/core/common/api_result.dart';

import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';

abstract class AuthUseCaseRepo {

  Future<Result<EditProfileEntity?>> editProfile(EditProfileRequest editProfileRequest);
}