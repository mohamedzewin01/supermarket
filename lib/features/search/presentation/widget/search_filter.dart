import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/resources/assets_manager.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../blocs/search_cubit.dart' show SearchCubit;

void showFilterBottomSheet(BuildContext context, SearchCubit viewModel) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 5,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                color: ColorManager.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 10,),


            SliderBody(viewModel: viewModel,),

            SizedBox(height: 15),
            OrderSelection(
              initialOrder: viewModel.order,
              onOrderChanged: (val) {

                  viewModel.sortBy = "product_price";
                  viewModel.order = val;

              },
            ),
            SizedBox(height: 25),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primaryColor,
                minimumSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                await viewModel.searchProducts(
                  search: viewModel.searchController.text,
                ).then((value) {

                },);
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset(Assets.filter),
              label: Text(
                'تطبيق',
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: 14,
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

class SliderBody extends StatefulWidget {
  const SliderBody({super.key, required this.viewModel, });
final SearchCubit viewModel;
  @override
  State<SliderBody> createState() => _SliderBodyState();
}

class _SliderBodyState extends State<SliderBody> {
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'السعر',
          style: getSemiBoldStyle(
            fontSize: 16,
            color: ColorManager.primaryColor,
          ),
        ),
        SfSlider(
          min: 0,
          max: 1000,
          value: _currentValue,
          enableTooltip: true,
          activeColor: ColorManager.primaryColor,
          inactiveColor: ColorManager.indigoLight,
          interval: 100,
          // showTicks: true,
          showDividers: true,
          showLabels: true,
          stepSize: 10,
          onChanged: (value) {
            setState(() {
           widget.viewModel.maxPrice = value.toInt();
              _currentValue = value;

            });
          },
        ),
      ],
    );
  }
}

class OrderSelection extends StatefulWidget {
  final String? initialOrder;
  final void Function(String) onOrderChanged;

  const OrderSelection({
    super.key,
    this.initialOrder,
    required this.onOrderChanged,
  });

  @override
  State<OrderSelection> createState() => _OrderSelectionState();
}

class _OrderSelectionState extends State<OrderSelection> {
  String? order;

  @override
  void initState() {
    super.initState();
    order = widget.initialOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<String>(
            activeColor:  ColorManager.primaryColor,
            value: 'asc',
            groupValue: order,
            title: Row(
              children: [

                Expanded(
                  child: AutoSizeText(
                    'من اقل الى اعلى',
                    style: getSemiBoldStyle(color: ColorManager.primaryColor),
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_upward, color: ColorManager.primaryColor),

              ],
            ),
            onChanged: (val) {
              setState(() {
                order = val;
                widget.onOrderChanged(val!);
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(

            activeColor:  ColorManager.primaryColor,
            value: 'desc',
            groupValue: order,
            title: Row(
              children: [

                Expanded(
                  child: AutoSizeText(
                    'من اعلى الى اقل',
                    style: getSemiBoldStyle(color: ColorManager.primaryColor),
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_downward, color: ColorManager.primaryColor),

              ],
            ),
            onChanged: (val) {
              setState(() {
                order = val;
                widget.onOrderChanged(val!);
              });
            },
          ),
        ),
      ],
    );
  }
}
