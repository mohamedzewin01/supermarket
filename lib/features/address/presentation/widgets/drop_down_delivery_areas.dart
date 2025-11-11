import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/rial_icon.dart';
import 'package:manarat_amjad/features/address/data/models/response/get_delivery_areas_dto.dart';
import 'package:manarat_amjad/features/address/presentation/blocs/areas/areas_cubit.dart';
import 'package:manarat_amjad/features/address/presentation/blocs/my_address/address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownDeliveryAreas extends StatefulWidget {
  const DropDownDeliveryAreas({super.key, this.initialAreaId});

  final int? initialAreaId;

  @override
  State<DropDownDeliveryAreas> createState() => _DropDownDeliveryAreasState();
}

class _DropDownDeliveryAreasState extends State<DropDownDeliveryAreas> {
  late AreasCubit viewModel;
  DataAreas? selectedArea;

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<AreasCubit>();
    viewModel.getAreas();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: BlocConsumer<AreasCubit, AreasState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AreasSuccess) {
            List<DataAreas>? deliveryAreas =
                state.deliveryAreasEntity.dataAreas?.reversed.toList() ?? [];
            if (selectedArea == null && widget.initialAreaId != null) {
              selectedArea = deliveryAreas.firstWhere(
                (area) => area.id == widget.initialAreaId,
              );
            }
            if (selectedArea == null && deliveryAreas.isNotEmpty) {
              selectedArea = deliveryAreas.first;
              context.read<AddressCubit>().idUserArea = deliveryAreas.first.id ?? 0;
              context.read<AddressCubit>().cityController.text =
                  deliveryAreas.first.areaName ?? '';
            }
            return Form(
              key: viewModel.formKeyAreas,
              child: DropdownButtonFormField<DataAreas>(
                isExpanded: true,

                hint: const Text('اختر منطقة التوصيل'),

                value: selectedArea,

                validator: (value) {
                  if (value == null) {

                    return 'الرجاء اختيار منطقة التوصيل';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  isDense: false,
                  fillColor: Colors.grey.shade100,
                  labelText: 'اختر منطقة التوصيل',

                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                items:
                    deliveryAreas.map((area) {
                      return DropdownMenuItem<DataAreas>(
                        value: area,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: AutoSizeText(
                                area.areaName ?? '',
                                style: getBoldStyle(
                                  color: ColorManager.redLight,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Spacer(),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'مقابل التوصيل: ',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.blueDark,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        area.deliveryCost == "0.00"
                                            ? "مجاني"
                                            : '${area.deliveryCost}',
                                    style: getSemiBoldStyle(
                                      color: ColorManager.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            area.deliveryCost == "0.00"
                                ? SizedBox()
                                : RialIcon(
                                  color: ColorManager.primaryColor,
                                  size: 12,
                                ),
                          ],
                        ),
                      );
                    }).toList(),
                iconSize: 25,
                onChanged: (DataAreas? value) {
                  setState(() {
                    selectedArea = value;
                    context.read<AddressCubit>().idUserArea = value?.id ?? 0;
                    context.read<AddressCubit>().cityController.text =
                        value?.areaName ?? '';
                  });
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
