import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_signup_response_dto.g.dart';

@JsonSerializable()
class AuthSignupResponseDto {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "user")
  final User? user;

  AuthSignupResponseDto({this.status, this.user});

  factory AuthSignupResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AuthSignupResponseDtoFromJson(json);
  }


  Map<String, dynamic> toJson() {
    return _$AuthSignupResponseDtoToJson(this);
  }

  AuthSignupEntity toAuthSignupEntity() =>
      AuthSignupEntity(status: status, user: user);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "is_active")
  final bool? isActive;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "created_at")
  final String? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.phone,
    this.role,
    this.isActive,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
