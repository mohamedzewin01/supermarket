import 'package:manarat_amjad/core/api/api_extentions.dart';
import 'package:manarat_amjad/core/api/api_manager/api_manager.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/features/address/data/datasources/address_data_source.dart';

import 'package:manarat_amjad/features/address/data/models/request/edit_address_request.dart';
import 'package:manarat_amjad/features/address/data/models/request/get_user_addresses.dart';
import 'package:manarat_amjad/features/address/domain/entities/address_entity.dart';
import 'package:manarat_amjad/features/cart/data/models/request/add_address.dart';
import 'package:manarat_amjad/features/cart/domain/entities/cart_entities.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressDataSource)
class AddressRemoteDataSourceImpl implements AddressDataSource {
  final ApiService _apiService;

  AddressRemoteDataSourceImpl(this._apiService);

  @override
  Future<Result<GetUserAddressEntity?>> getUserAddress() {
    return executeApi(() async {
      int? userId = await CacheService.getData(key: CacheKeys.userId) ?? 0;
      GetUserAddressesRequest getUserAddressRequest = GetUserAddressesRequest(
        userId: userId,
      );
      var response = await _apiService.fetchAddressesUser(
        getUserAddressRequest,
      );
      return response?.toGetUserAddressEntity();
    });
  }

  @override
  Future<Result<AddAddressUserEntity?>> addAddressesUser(
    AddAddressRequest addAddressRequest,
  ) {
    return executeApi(() async {
      var response = await _apiService.addAddressesUser(addAddressRequest);
      return response?.toAddAddressUserEntity();
    });
  }

  @override
  Future<Result<DeliveryAreasEntity?>> getDeliveryAreas() {
    return executeApi(() async {
      var response = await _apiService.getDeliveryAreas();
      return response?.toDeliveryAreasEntity();
    });
  }

  @override
  Future<Result<EditAddressEntity?>> editAddressesUser(
    EditAddressRequest editAddressRequest,
  ) {
    return executeApi(() async {
      var response = await _apiService.editAddress(editAddressRequest);
      return response?.toEditAddressEntity();
    });
  }
}
