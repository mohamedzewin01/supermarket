import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_app_bar.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/features/address/data/models/response/get_user_dto.dart';
import 'package:manarat_amjad/features/address/presentation/widgets/add_address.dart';
import 'package:manarat_amjad/features/address/presentation/blocs/my_address/address_cubit.dart';
import 'package:manarat_amjad/features/address/presentation/widgets/address_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late AddressCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<AddressCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel..getAddress(),
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: CustomAppBar(
          title: 'العناوين',
          onBackTap: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocConsumer<AddressCubit, AddressState>(
                  listener: (context, state) {
                    if (state is AddAddressSuccess) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }

                  },
                  builder: (context, state) {
                    if (state is AddressSuccess) {
                      List<DataAddresses> addresses =
                          state.addressesUserEntity.data?.reversed.toList() ??
                          [];
                      return addresses.isNotEmpty
                          ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder:
                                (context, index) => AddressItem(
                                  viewModel: viewModel,
                                  addresses: addresses[index],
                                ),
                            itemCount: addresses.length,
                          )
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 18,
                            children: [
                              Icon(Icons.event_note,color: ColorManager.primaryColor,size: 45,),
                              Center(
                                child: Text(
                                  'لا يوجد عناوين',
                                  style: getSemiBoldStyle(
                                    color: ColorManager.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          );
                    }
                    if(state is AddressLoading){
                      return SkeAddress();
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  viewModel.scaffoldKey.currentState?.showBottomSheet(
                    elevation: 5,
                    (context) => AddAddress(viewModel: viewModel),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.primaryColor,
                  ),
                  child: Icon(Icons.add, color: ColorManager.white),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
