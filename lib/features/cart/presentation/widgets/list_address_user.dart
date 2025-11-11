import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/features/address/data/models/response/get_user_dto.dart';
import 'package:manarat_amjad/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListAddressUser extends StatefulWidget {
  const ListAddressUser({super.key, this.addresses});

  final List<DataAddresses>? addresses;

  @override
  State<ListAddressUser> createState() => _ListAddressUserState();
}

class _ListAddressUserState extends State<ListAddressUser> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Container(height: 1, color: Colors.grey.shade300,),

        itemCount: widget.addresses?.length ?? 0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SizedBox(
              child: ListTile(
                onTap: () {
                  print('widget.addresses?[index].id');
                  setState(() {

                    selectedIndex = selectedIndex == index ? null : index;

                    context.read<CartCubit>().updateIdAddress(widget.addresses?[index].id);

                    // print(widget.addresses?[index].id);
                    print('55555555555555555555555555555555555555555555555');
                    print('${CartCubit.get(context).idAddress}');
                  });
                },
                leading: Icon(
                  Icons.location_on,
                  color: selectedIndex == index
                      ? ColorManager.primaryColor
                      : ColorManager.green,
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.addresses?[index].title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                          color: selectedIndex == index
                              ? ColorManager.primaryColor
                              : ColorManager.blue,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.addresses?[index].city ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getSemiBoldStyle(
                          color: selectedIndex == index
                              ? ColorManager.primaryColor
                              : ColorManager.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  widget.addresses?[index].details ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                    color: selectedIndex == index
                        ? ColorManager.primaryColor
                        : ColorManager.black,
                    fontSize: 12,
                  ),
                ),
                trailing: Radio<int>(
                  value: index,
                  activeColor: selectedIndex == index
                      ? ColorManager.primaryColor
                      : ColorManager.black,
                  groupValue: selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      // تغيير selectedIndex بشكل صحيح
                      selectedIndex = value;
                      // تعيين ID العنوان في الـ CartCubit
                      context.read<CartCubit>().updateIdAddress(widget.addresses?[index].id);

                      // print(widget.addresses?[index].id);
                      print('55555555555555555555555555555555555555555555555');
                      print('${CartCubit.get(context).idAddress}');
                    });
                  },
                ),
              )

          );
        },
      ),
    );
  }
}


