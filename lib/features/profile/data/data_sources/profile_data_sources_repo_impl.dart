

import 'package:manarat_amjad/core/api/api_extentions.dart';
import 'package:manarat_amjad/core/api/api_manager/api_manager.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:manarat_amjad/features/profile/data/data_sources/profile_data_sources_repo.dart';
import 'package:manarat_amjad/features/profile/data/models/request/get_user_info_request.dart';
import 'package:manarat_amjad/features/profile/domain/entities/profile_entities.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: ProfileDataSourcesRepo)
class ProfileDataSourcesRepoImpl implements ProfileDataSourcesRepo {
  final ApiService _apiService;

  ProfileDataSourcesRepoImpl(this._apiService);
  @override
  Future<Result<GetUserInfoEntity?>> getUserInfo(GetUserInfoRequest getUserInfoRequest) {
 return executeApi(() async {
   var response = await _apiService.getUserInfo(getUserInfoRequest);
   return response?.toGetUserInfoEntity();
 });
  }

  @override
  Future<Result<EditProfileEntity?>> editProfile(EditProfileRequest editProfileRequest) {
   return executeApi(() async {
     var response = await _apiService.editProfile(editProfileRequest);
     return response?.toEditProfileEntity();
   });
  }
}