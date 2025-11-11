import 'package:bloc/bloc.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/core/uses_cases/profile/profile_use_case_repo.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/features/auth/data/models/request/edit_profile_request.dart';
import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:manarat_amjad/features/profile/data/models/request/get_user_info_request.dart';
import 'package:manarat_amjad/features/profile/domain/entities/profile_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';


@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileUseCaseRepo) : super(ProfileInitial());
  final ProfileUseCaseRepo _profileUseCaseRepo;

  static ProfileCubit get(context) => BlocProvider.of(context);
  Future<void> getProfile() async {
    emit(ProfileLoading());
    int? userId = await CacheService.getData(key: CacheKeys.userId) ?? 0;
    GetUserInfoRequest getUserInfoRequest = GetUserInfoRequest(
      id: userId,
    );
    final result = await _profileUseCaseRepo.getUserInfo(getUserInfoRequest);
    switch (result) {
      case Success<GetUserInfoEntity?>():
        {
          if (!isClosed) {


            emit(ProfileSuccess(result.data!));
          }
        }
      case Fail<GetUserInfoEntity?>():
        {
          emit(ProfileFail(result.exception));
        }
    }


  }




  Future<void> editProfile({required String email,required String name,required String phone}) async {
    emit(EditProfileLoading());
    EditProfileRequest editProfileRequest = EditProfileRequest(
      id: CacheService.getData(key: CacheKeys.userId),
      email: email,
      name: name,
      phone: phone
    );
    var result = await _profileUseCaseRepo.editProfile(editProfileRequest);

    switch (result) {
      case Success<EditProfileEntity?>():
        {
          if (!isClosed) {

            emit(EditProfileSuccess(result.data!));
            await getProfile();
          }
        }
      case Fail<EditProfileEntity?>():
        {
          emit(EditProfileFail(result.exception));
        }
    }
  }



}
