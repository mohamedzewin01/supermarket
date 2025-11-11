import 'package:manarat_amjad/features/profile/domain/entities/profile_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user_info_dto.g.dart';

@JsonSerializable()
class GetProfileUserInfoDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "user")
  final ProfileUser? user;

  GetProfileUserInfoDto ({
    this.status,
    this.user,
  });

  factory GetProfileUserInfoDto.fromJson(Map<String, dynamic> json) {
    return _$GetProfileUserInfoDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetProfileUserInfoDtoToJson(this);
  }
  GetUserInfoEntity toGetUserInfoEntity() {
    return GetUserInfoEntity(
      status: status,
      user: user,
    );
  }
}

@JsonSerializable()
class ProfileUser {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "profile_image")
  final String? profileImage;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "is_active")
  final int? isActive;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "last_login")
  final String? lastLogin;
  @JsonKey(name: "verified_at")
  final String? verifiedAt;

  ProfileUser ({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.profileImage,
    this.role,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.verifiedAt,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return _$ProfileUserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileUserToJson(this);
  }
}


