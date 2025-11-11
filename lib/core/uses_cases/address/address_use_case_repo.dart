import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/address/data/models/request/edit_address_request.dart';
import 'package:manarat_amjad/features/address/domain/entities/address_entity.dart';
import 'package:manarat_amjad/features/cart/data/models/request/add_address.dart';
import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';

abstract class AddressUseCaseRepo {
  Future<Result<GetUserAddressEntity?>> getUserAddress();

  Future<Result<DeliveryAreasEntity?>> getDeliveryAreas();

  Future<Result<AddAddressUserEntity?>> addAddressesUser(
    AddAddressRequest addAddressRequest,
  );

  Future<Result<EditAddressEntity?>> editAddressesUser(
    EditAddressRequest editAddressRequest,
  );
}
