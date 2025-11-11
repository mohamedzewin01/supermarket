import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/features/address/data/datasources/address_data_source.dart';
import 'package:manarat_amjad/features/address/data/models/request/edit_address_request.dart';
import 'package:manarat_amjad/features/address/domain/entities/address_entity.dart';
import 'package:manarat_amjad/features/address/domain/repositories/address_repository.dart';
import 'package:manarat_amjad/features/cart/data/models/request/add_address.dart';
import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: AddressRepository)
class AddressRepositoryImpl implements AddressRepository {
  final AddressDataSource addressDataSource;

  AddressRepositoryImpl(this.addressDataSource);

  @override
  Future<Result<GetUserAddressEntity?>> getUserAddress() {
    return addressDataSource.getUserAddress();
  }

  @override
  Future<Result<AddAddressUserEntity?>> addAddressesUser(
    AddAddressRequest addAddressRequest,
  ) {
    return addressDataSource.addAddressesUser(addAddressRequest);
  }

  @override
  Future<Result<DeliveryAreasEntity?>> getDeliveryAreas() {
    return addressDataSource.getDeliveryAreas();
  }

  @override
  Future<Result<EditAddressEntity?>> editAddressesUser(EditAddressRequest editAddressRequest) {
   return addressDataSource.editAddressesUser(editAddressRequest);
  }
}
