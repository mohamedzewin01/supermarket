import 'package:fada_alhalij_web/core/api/api_extentions.dart';
import 'package:fada_alhalij_web/core/api/api_manager/api_manager.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/features/address/data/datasources/address_data_source.dart';

import 'package:fada_alhalij_web/features/address/data/models/request/edit_address_request.dart';
import 'package:fada_alhalij_web/features/address/data/models/request/get_user_addresses.dart';
import 'package:fada_alhalij_web/features/address/domain/entities/address_entity.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/add_address.dart';
import 'package:fada_alhalij_web/features/cart/domain/entities/cart_entities.dart';
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
