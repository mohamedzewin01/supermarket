import 'package:bloc/bloc.dart';
import 'package:manarat_amjad/core/common/api_result.dart';
import 'package:manarat_amjad/core/uses_cases/address/address_use_case_repo.dart';
import 'package:manarat_amjad/features/address/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'areas_state.dart';


@injectable
class AreasCubit extends Cubit<AreasState> {
  AreasCubit(this._addressUseCaseRepo) : super(AreasInitial());
  final AddressUseCaseRepo _addressUseCaseRepo;

static AreasCubit get(context) => BlocProvider.of(context);
  final formKeyAreas = GlobalKey<FormState>();
  Future<void> getAreas() async {
    emit(AreasLoading());
    final result = await _addressUseCaseRepo.getDeliveryAreas();
    switch (result) {
      case Success<DeliveryAreasEntity?>():
        {
          if (!isClosed) {
            emit(AreasSuccess(result.data!));
          }
        }
      case Fail<DeliveryAreasEntity?>():
        {
          emit(AreasFail(result.exception));
        }
    }
  }

}
