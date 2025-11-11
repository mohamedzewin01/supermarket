import 'package:manarat_amjad/features/auth/domain/entities/auth_entities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_dto.g.dart';

@JsonSerializable()
class EditProfileDto {
  @JsonKey(name: "status")
  final bool? status;
  @JsonKey(name: "message")
  final String? message;

  EditProfileDto ({
    this.status,
    this.message,
  });

  factory EditProfileDto.fromJson(Map<String, dynamic> json) {
    return _$EditProfileDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$EditProfileDtoToJson(this);
  }

  EditProfileEntity toEditProfileEntity() {
    return EditProfileEntity(
      status: status,
      message: message,
    );
  }
}


