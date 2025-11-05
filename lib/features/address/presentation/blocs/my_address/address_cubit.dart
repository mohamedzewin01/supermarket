import 'package:bloc/bloc.dart';
import 'package:fada_alhalij_web/core/common/api_result.dart';
import 'package:fada_alhalij_web/core/uses_cases/address/address_use_case_repo.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/features/address/data/models/request/edit_address_request.dart';
import 'package:fada_alhalij_web/features/address/domain/entities/address_entity.dart';
import 'package:fada_alhalij_web/features/cart/data/models/request/add_address.dart';
import 'package:fada_alhalij_web/features/cart/domain/entities/cart_entities.dart';
import 'package:fada_alhalij_web/features/cart/domain/use_cases/cart_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'address_state.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this._cartUseCase) : super(AddressInitial());

  final AddressUseCaseRepo _cartUseCase;

  static AddressCubit get(context) => BlocProvider.of(context);
  int? idAddress;
  final formKeyAddAddress = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKeyAreas = GlobalKey<FormState>();

  Future<void> getAddress() async {
    emit(AddressLoading());
    final result = await _cartUseCase.getUserAddress();
    switch (result) {
      case Success<GetUserAddressEntity?>():
        {
          if (!isClosed) {
            emit(AddressSuccess(result.data!));
          }
        }
      case Fail<GetUserAddressEntity?>():
        {
          emit(AddressFailure(result.exception));
        }
    }
  }

  final titleController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final detailsController = TextEditingController();

  int? idUser = CacheService.getData(key: CacheKeys.userId) ?? 0;

  int idUserArea = 0;
int deliveryAreaId = 0;
  changeIdUserArea(int id) {
    idUserArea = id;
    emit(ChangeIdUserArea());
  }

  Future<void> addAddress() async {
    emit(AddAddressLoading());
    AddAddressRequest addAddressRequest = AddAddressRequest(
      deliveryAreaId: idUserArea,
      userId: idUser,
      title: titleController.text,
      street: streetController.text,
      city: cityController.text,
      lat: latController.text,
      long: longController.text,
      details: detailsController.text,
    );
    final result = await _cartUseCase.addAddressesUser(addAddressRequest);
    switch (result) {
      case Success<AddAddressUserEntity?>():
        {
          if (!isClosed) {
            emit(AddAddressSuccess(result.data!));
            titleController.clear();
            streetController.clear();
            cityController.clear();
            latController.clear();
            longController.clear();
            detailsController.clear();
          }
        }
      case Fail<AddAddressUserEntity?>():
        {
          emit(AddressFailure(result.exception));
        }
    }
  }

  void setIdAddress(int? idAddress) {
    if (state is OrdersWithAddress) {
      emit((state as OrdersWithAddress).copyWith(idAddress: idAddress));
    } else {
      // في حال كانت الحالة غير حالة OrdersWithAddress، نقوم بتعيين القيمة فقط
      emit(OrdersWithAddress(idAddress: idAddress));
    }
  }

  void deleteAddress({required int idAddress,required int deliveryAreaId }) async {

    int? userId = await CacheService.getData(key: CacheKeys.userId) ?? 0;
    final result = await _cartUseCase.editAddressesUser(
      EditAddressRequest(isActive: 0,userId: userId,id: idAddress,deliveryAreaId: deliveryAreaId,),
    );
    switch (result) {
      case Success<EditAddressEntity?>():
        {
          if (!isClosed) {
            getAddress();
          }
        }
      case Fail<EditAddressEntity?>():
        {

        }
    }
  }


  Future<void> editAddress({required  EditAddressRequest editAddressRequest}) async {


    final result = await _cartUseCase.editAddressesUser(editAddressRequest);
    switch (result) {
      case Success<EditAddressEntity?>():
        {
          if (!isClosed) {
            getAddress();
          }
        }
      case Fail<EditAddressEntity?>():
        {
          // emit(EditAddressFailure(result.exception));
        }
    }
  }
}
