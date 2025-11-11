import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_product_card.dart';
import 'package:manarat_amjad/features/best_deals/data/models/best_deals_by_discount.dart';
import 'package:manarat_amjad/features/best_deals/presention/cubit/best_by_discount/best_discount_by_discount_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';


class BestDealsByDiscountView extends StatefulWidget {
  const BestDealsByDiscountView({super.key, this.discount});

  final int? discount;

  @override
  State<BestDealsByDiscountView> createState() =>
      _BestDealsByDiscountViewState();
}

class _BestDealsByDiscountViewState extends State<BestDealsByDiscountView> {
  late BestDiscountByDiscountCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<BestDiscountByDiscountCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel..getBestDealsByCategories(widget.discount),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorManager.primaryColor,
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Center(child: Icon(Icons.arrow_back_ios)),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount =
                    constraints.maxWidth > 900
                        ? 5
                        : constraints.maxWidth > 700
                        ? 3
                        : 2;
                return BlocBuilder<
                  BestDiscountByDiscountCubit,
                  BestDiscountByDiscountState
                >(
                  builder: (context, state) {
                    if (state is BestDiscountByDiscountSuccess) {
                      List<BestDeals> bestDealsByDiscount =
                          state.bestDealsByDiscountEntity.bestDeals?.reversed
                              .toList() ??
                          [];

                      ///
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: bestDealsByDiscount.length,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 260,
                              ),
                          itemBuilder:
                              (context, index) => CustomProductCardWidget(
                                product:
                                    bestDealsByDiscount[index]
                                        .toProductsRelations(),
                              ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ), // تأكد من إزالة أي padding
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primaryColor,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


