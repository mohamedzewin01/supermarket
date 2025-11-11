import 'package:manarat_amjad/features/address/data/models/response/get_delivery_areas_dto.dart';
import 'package:manarat_amjad/features/address/data/models/response/get_user_dto.dart';


class GetUserAddressEntity {

  final bool? status;

  final String? message;

  final List<DataAddresses>? data;

  GetUserAddressEntity ({
    this.status,
    this.message,
    this.data,
  });


}


class DeliveryAreasEntity {

  final bool? status;

  final List<DataAreas>? dataAreas;

  DeliveryAreasEntity ({
    this.status,
    this.dataAreas,
  });


}

class EditAddressEntity {

  final bool? status;

  final String? message;

  EditAddressEntity ({
    this.status,
    this.message,
  });


}