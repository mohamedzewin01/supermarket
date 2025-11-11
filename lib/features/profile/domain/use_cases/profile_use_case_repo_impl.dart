import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/core/uses_cases/profile/profile_use_case_repo.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:manarat_amjad/features/profile/data/models/request/get_user_info_request.dart';
import 'package:manarat_amjad/features/profile/domain/entities/profile_entities.dart';
import 'package:manarat_amjad/features/profile/domain/repo/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileUseCaseRepo)
class ProfileUseCaseRepoImpl implements ProfileUseCaseRepo {
  final ProfileRepo profileRepo;

  ProfileUseCaseRepoImpl(this.profileRepo);

  @override
  Future<Result<GetUserInfoEntity?>> getUserInfo(
    GetUserInfoRequest getUserInfoRequest,
  ) {
    return profileRepo.getUserInfo(getUserInfoRequest);
  }

  @override
  Future<Result<EditProfileEntity?>> editProfile(EditProfileRequest editProfileRequest) {
   return profileRepo.editProfile(editProfileRequest);
  }
}
