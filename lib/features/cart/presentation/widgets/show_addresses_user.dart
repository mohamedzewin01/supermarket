import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/features/address/data/models/response/get_user_dto.dart';
import 'package:manarat_amjad/features/address/presentation/blocs/my_address/address_cubit.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../address/presentation/widgets/add_address.dart';
import 'list_address_user.dart';

class ShowAddressesUser extends StatefulWidget {
  const ShowAddressesUser({super.key});

  @override
  State<ShowAddressesUser> createState() => _ShowAddressesUserState();
}

class _ShowAddressesUserState extends State<ShowAddressesUser> {
  late AddressCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<AddressCubit>();
    viewModel.getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddAddressSuccess) {
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop();
          }
          if (state is AddressFailure) {}
          if (state is AddAddressLoading) {
            CustomDialog.showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          if (state is AddressSuccess) {
            List<DataAddresses>? addresses =
                state.addressesUserEntity.data?.reversed.toList() ?? [];
            // return Text("data");
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          " التوصيل الي:",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: getSemiBoldStyle(
                            fontSize: 14,
                            color: ColorManager.indigoDark2,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          CartCubit.get(
                            context,
                          ).scaffoldKey.currentState?.showBottomSheet(
                            elevation: 5,
                            (context) => AddAddress(viewModel: viewModel),
                          );
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: ColorManager.primaryColor,
                          child: Icon(
                            Icons.add,
                            color: ColorManager.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListAddressUser(addresses: addresses),
                ],
              ),
            );
          }

          return Skeletonizer(
            child: Card(
              color: ColorManager.white.withAlpha(200),
              elevation: 4,
              child: ListTile(
                onTap: () {},
                leading: Icon(Icons.location_on, color: ColorManager.black),

                title: Text(
                  "aasasas",
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: 12,
                  ),
                ),
                subtitle: Text(
                  "sdsdsadsadsda",
                  style: getSemiBoldStyle(
                    color: ColorManager.black,
                    fontSize: 12,
                  ),
                ),
                trailing: Radio<int>(
                  value: 1,
                  activeColor: ColorManager.black,
                  groupValue: 1,
                  onChanged: (value) {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
