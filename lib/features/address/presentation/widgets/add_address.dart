// import 'package:manarat_amjad/core/resources/color_manager.dart';
// import 'package:manarat_amjad/core/resources/style_manager.dart';
// import 'package:manarat_amjad/core/widgets/custom_text_form_field.dart';
// import 'package:manarat_amjad/core/widgets/get_location.dart';
// import 'package:manarat_amjad/features/address/presentation/widgets/drop_down_delivery_areas.dart';
// import 'package:manarat_amjad/features/address/presentation/blocs/my_address/address_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
//
// class AddAddress extends StatefulWidget {
//   const AddAddress({super.key, required this.viewModel});
//
//   final AddressCubit viewModel;
//
//   @override
//   State<AddAddress> createState() => _AddAddressState();
// }
//
// class _AddAddressState extends State<AddAddress> {
//   bool isAccepted = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: widget.viewModel,
//       child: SingleChildScrollView(
//         child: GestureDetector(
//           onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(20),
//                 child: Form(
//                   key: widget.viewModel.formKeyAddAddress,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const SizedBox(height: 20),
//                       CustomTextFormField(
//                         controller: widget.viewModel.titleController,
//                         labelText: "مسمى العنوان",
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'من فضلك ادخل المسمى';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 15),
//
//                       DropDownDeliveryAreas(),
//                       const SizedBox(height: 15),
//                       CustomTextFormField(
//                         controller: widget.viewModel.streetController,
//                         labelText: "الشارع",
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'من فضلك ادخل الشارع';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 15),
//                       CustomTextFormField(
//                         controller: widget.viewModel.detailsController,
//                         labelText: "تفاصيل",
//                         maxLines: 3,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'من فضلك ادخل التفاصيل';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: isAccepted,
//                             onChanged: (value) async{
//
//                                 setState(()  {
//                                   isAccepted = !isAccepted;
//
//                                 });
//                                 if (isAccepted) {
//                                   await getLocation(widget.viewModel);
//                                 }
//
//                             },
//                             checkColor: Colors.white,
//                             activeColor: ColorManager.primaryColor,
//                             side: BorderSide(
//                               color: ColorManager.primaryColor,
//                               width: 2,
//                             ),
//                           ),
//                           Expanded(
//                             child: RichText(
//                               text: TextSpan(
//                                 children: [
//                                   TextSpan(
//                                     text: 'استخدم الموقع الحالي',
//                                     style: getSemiBoldStyle(
//                                       color: ColorManager.primaryColor,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               isAccepted
//                                   ? ColorManager.primaryColor
//                                   : Colors.grey,
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () async {
//                           FocusManager.instance.primaryFocus?.unfocus();
//
//                           if (!widget.viewModel.formKeyAddAddress.currentState!
//                               .validate()) {
//                             return;
//                           }
//                           if (!isAccepted) return;
//                           await widget.viewModel.addAddress();
//                           await widget.viewModel.getAddress();
//                           if (context.mounted) {
//
//                           }
//                         },
//
//                         child: const Text(
//                           "حفظ العنوان",
//                           style: TextStyle(fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -20,
//                 right: 20,
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundColor: Colors.red,
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.of(context, rootNavigator: true).pop();
//                     },
//                     icon: const Icon(Icons.close, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_text_form_field.dart';
import 'package:manarat_amjad/core/widgets/get_location.dart';
import 'package:manarat_amjad/features/address/presentation/widgets/drop_down_delivery_areas.dart';
import 'package:manarat_amjad/features/address/presentation/blocs/my_address/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key, required this.viewModel});

  final AddressCubit viewModel;

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  bool isAccepted = false;
  String? selectedTitle;
  final TextEditingController customTitleController = TextEditingController();

  final List<String> addressTitles = [
    'المنزل',
    'العمل',
    'الشقة',
    'المكتب',
    'أخرى',
  ];

  @override
  void dispose() {
    customTitleController.dispose();
    super.dispose();
  }

  String? _getFinalTitle() {
    if (selectedTitle == 'أخرى') {
      return customTitleController.text.trim();
    }
    return selectedTitle;
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

                      // Address title selector with Wrap
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مسمى العنوان',
                            style: getSemiBoldStyle(
                              color: ColorManager.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: addressTitles.map((title) {
                              final isSelected = selectedTitle == title;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedTitle = title;
                                    if (title != 'أخرى') {
                                      customTitleController.clear();
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorManager.primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? ColorManager.primaryColor
                                          : ColorManager.primaryColor
                                          .withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    title,
                                    style: getSemiBoldStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          if (selectedTitle == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8, right: 8),
                              child: Text(
                                'من فضلك اختر مسمى العنوان',
                                style: getRegularStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Custom title text field (appears when "أخرى" is selected)
                      if (selectedTitle == 'أخرى') ...[
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: customTitleController,
                          labelText: "اكتب المسمى",
                          validator: (value) {
                            if (selectedTitle == 'أخرى' &&
                                (value == null || value.isEmpty)) {
                              return 'من فضلك ادخل المسمى';
                            }
                            return null;
                          },
                        ),
                      ],

                      const SizedBox(height: 15),
                      DropDownDeliveryAreas(),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: widget.viewModel.streetController,
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
                        controller: widget.viewModel.detailsController,
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
                          backgroundColor: isAccepted
                              ? ColorManager.primaryColor
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();

                          // Validate address title selection
                          if (selectedTitle == null) {
                            setState(() {}); // Trigger rebuild to show error
                            return;
                          }

                          if (!widget.viewModel.formKeyAddAddress.currentState!
                              .validate()) {
                            return;
                          }
                          if (!isAccepted) return;

                          // Set the final title in the controller
                          final finalTitle = _getFinalTitle();
                          if (finalTitle != null && finalTitle.isNotEmpty) {
                            widget.viewModel.titleController.text = finalTitle;
                          }

                          await widget.viewModel.addAddress();
                          await widget.viewModel.getAddress();
                          if (context.mounted) {
                            // Navigator.pop or show success message
                          }
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