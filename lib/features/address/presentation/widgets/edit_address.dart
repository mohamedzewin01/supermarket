import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import 'package:fada_alhalij_web/core/resources/style_manager.dart';
import 'package:fada_alhalij_web/core/utils/cashed_data_shared_preferences.dart';
import 'package:fada_alhalij_web/core/widgets/custom_text_form_field.dart';
import 'package:fada_alhalij_web/core/widgets/get_location.dart';
import 'package:fada_alhalij_web/features/address/data/models/request/edit_address_request.dart';
import 'package:fada_alhalij_web/features/address/data/models/response/get_user_dto.dart';
import 'package:fada_alhalij_web/features/address/presentation/widgets/drop_down_delivery_areas.dart';
import 'package:fada_alhalij_web/features/address/presentation/blocs/my_address/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({
    super.key,
    required this.viewModel,
    required this.address,
  });

  final AddressCubit viewModel;
  final DataAddresses address;

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  bool isAccepted = false;
  late TextEditingController titleController;
  late TextEditingController streetController;
  late TextEditingController detailsController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.address.title);
    streetController = TextEditingController(text: widget.address.street);
    detailsController = TextEditingController(text: widget.address.details);
  }

  @override
  void dispose() {
    titleController.dispose();
    streetController.dispose();
    detailsController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return BlocProvider.value(
      value: widget.viewModel,
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: widget.viewModel.formKeyAddAddress,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: titleController,
                        labelText: "مسمى العنوان",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل المسمى';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      DropDownDeliveryAreas(initialAreaId: widget.address.deliveryAreaId,),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: streetController,
                        labelText: "الشارع",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل الشارع';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: detailsController,
                        labelText: "تفاصيل",
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل التفاصيل';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isAccepted,
                            onChanged: (value) async {
                              setState(() {
                                isAccepted = !isAccepted;
                              });
                              if (isAccepted) {
                                await getLocation(widget.viewModel);
                              }
                            },
                            checkColor: Colors.white,
                            activeColor: ColorManager.primaryColor,
                            side: BorderSide(
                              color: ColorManager.primaryColor,
                              width: 2,
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'استخدم الموقع الحالي',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:

                                  ColorManager.primaryColor,

                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          int? userId = await CacheService.getData(key: CacheKeys.userId);
                          if (userId == null) {
                            return;
                          }
                          FocusManager.instance.primaryFocus?.unfocus();

                          if (!widget.viewModel.formKeyAddAddress.currentState!
                              .validate()) {
                            return;
                          }
                          widget.viewModel.editAddress(
                            editAddressRequest: EditAddressRequest(
                              id: widget.address.id,
                              title: titleController.text,
                              street: streetController.text,
                              city: widget.viewModel.cityController.text,
                              details: detailsController.text,
                              deliveryAreaId: widget.viewModel.idUserArea,
                              userId: userId,
                            ),
                          ).then((value) => Navigator.pop(context));

                        },

                        child: const Text(
                          "حفظ العنوان",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -20,
                right: 20,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
