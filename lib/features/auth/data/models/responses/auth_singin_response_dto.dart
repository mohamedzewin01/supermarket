import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_singin_response_dto.g.dart';

@JsonSerializable()
class AuthSingInResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserSignin? user;

  AuthSingInResponseDto({this.status, this.message, this.user});

  factory AuthSingInResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AuthSingInResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthSingInResponseDtoToJson(this);
  }

  AuthSingInEntity toAuthSingInEntity() =>
      AuthSingInEntity(status: status, message: message, user: user);
}

@JsonSerializable()
class UserSignin {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "username")
  final String? username;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "created_at")
  final String? createdAt;

  UserSignin({
    this.id,
    this.username,
    this.email,
    this.gender,
    this.photo,
    this.phone,
    this.createdAt,
  });

  factory UserSignin.fromJson(Map<String, dynamic> json) {
    return _$UserSigninFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserSigninToJson(this);
  }
}
