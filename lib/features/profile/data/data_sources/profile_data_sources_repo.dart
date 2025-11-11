
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:manarat_amjad/features/profile/data/models/request/get_user_info_request.dart';
import 'package:manarat_amjad/features/profile/domain/entities/profile_entities.dart';

abstract class ProfileDataSourcesRepo {
  Future<Result<GetUserInfoEntity?>>getUserInfo(GetUserInfoRequest getUserInfoRequest);
  Future<Result<EditProfileEntity?>> editProfile(EditProfileRequest editProfileRequest);
}