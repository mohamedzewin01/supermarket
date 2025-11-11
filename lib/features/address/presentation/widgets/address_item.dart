import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/features/address/data/models/response/get_user_dto.dart';
import 'package:manarat_amjad/features/address/presentation/blocs/my_address/address_cubit.dart';
import 'package:manarat_amjad/features/address/presentation/widgets/edit_address.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.viewModel,
    required this.addresses,
  });

  final AddressCubit viewModel;
  final DataAddresses addresses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              CustomDialog.showDeleteDialog(
                context,
                onPressed: () {
                  viewModel.deleteAddress(
                    idAddress:
                    addresses.id ?? 0,
                    deliveryAreaId:
                    addresses
                        .deliveryAreaId ??
                        0,
                  );
                  Navigator.pop(context);
                },
              );
            },
            child: Icon(
              Icons.clear,
              color: ColorManager.error,
            ),
          ),
          Expanded(
            child: Card(
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        addresses.title ?? '',
                        style: getSemiBoldStyle(
                          color: ColorManager.error,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        addresses.city ?? '',
                        style: getSemiBoldStyle(
                          color:
                          ColorManager
                              .primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  (addresses.details ?? ''),
                ),
                onTap: () {
                  /// TODO: SHOW ADDRESS
                },
                leading: Icon(
                  Icons.location_on_outlined,
                ),
                trailing: GestureDetector(
                  onTap: () {
                    viewModel.scaffoldKey.currentState
                        ?.showBottomSheet(
                      elevation: 5,
                          (context) => EditAddress(
                        viewModel: viewModel,
                        address: addresses,
                      ),
                    );
                  },
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkeAddress extends StatelessWidget {
  const SkeAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: List.generate(
          3,
              (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    CustomDialog.showDeleteDialog(
                      context,
                      onPressed: () {



                      },
                    );
                  },
                  child: Icon(
                    Icons.clear,
                    color: ColorManager.error,
                  ),
                ),
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'SSSSSSS',
                              style: getSemiBoldStyle(
                                color: ColorManager.error,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'SSSSSSS',
                              style: getSemiBoldStyle(
                                color:
                                ColorManager
                                    .primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        ('SSSSSSSSSSSSSS'),
                      ),
                      onTap: () {
                        /// TODO: SHOW ADDRESS
                      },
                      leading: Icon(
                        Icons.location_on_outlined,
                      ),
                      trailing: GestureDetector(
                        onTap: () {


                        },
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ],
            )))
      ),
    );
  }
}
