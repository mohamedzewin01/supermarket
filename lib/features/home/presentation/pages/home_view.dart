import 'package:auto_size_text/auto_size_text.dart';
import 'package:fada_alhalij_web/core/resources/app_constants.dart';
import 'package:fada_alhalij_web/core/resources/routes_manager.dart';
import 'package:fada_alhalij_web/core/widgets/custom_dialog.dart';
import 'package:fada_alhalij_web/core/widgets/custom_sliver_app_bar.dart';
import 'package:fada_alhalij_web/features/home/presentation/widgets/custom_card.dart';
import 'package:fada_alhalij_web/features/home/presentation/widgets/sek_home.dart';
import 'package:fada_alhalij_web/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fada_alhalij_web/core/resources/color_manager.dart';
import '../../../../core/di/di.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/widgets/see_all_view.dart';
import '../../../layout/presentation/cubit/layout_cubit.dart';
import '../../data/models/response/home_model_response_dto.dart';
import '../cubit/home_cubit.dart';
import '../widgets/app_bar_body.dart';
import '../widgets/carousel.dart';
import '../widgets/grid_categories.dart';
import '../widgets/horizontal_product_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeCubit viewModel;

  @override
  void initState() {
    viewModel = getIt<HomeCubit>();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              CustomSliverAppBar(title: "تموينات منارة أمجاد"),
              // AppBarBody(store: store)
            ];
          },
          body: BlocProvider.value(
            value: viewModel..getHomeData(),
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if(state is HomeFail){

                  final errorMessage = state.exception.toString();
                  print(errorMessage);
                  CustomDialog.showErrorDialog(context, message: errorMessage);
                }
              },

              builder: (context, state) {
                if (state is HomeSuccess){
                  List<Categories>? categories =
                      state.homeEntity?.data?.category?.categories ?? [];
                  List<ProductsBestDeals>? bestDeals =
                      state.homeEntity?.data?.bestDeals?.productsBestDeals?.reversed
                          .toList() ??
                          [];
                  List<Banners> banners =
                      state.homeEntity?.data?.banner?.banners ?? [];
                  List<Discounts>? discount =
                      state.homeEntity?.data?.discount?.discounts ?? [];
                  return RefreshIndicator(
                    color: ColorManager.primaryColor,
                    onRefresh: () => viewModel.getHomeData(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomCard(discounts: discount),
                          Column(
                            children: [
                              SizedBox(height: 8),
                              SeeAllView(
                                context: context,
                                name:
                                '${AppLocalizations.of(context)!.categories} 🛍️',
                                onTapAction: () {
                                  LayoutCubit.get(context).changeIndex(1);
                                },
                              ),
                              SizedBox(height: 16),
                              GridCategories(categories: categories),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Carousel(banners: banners),
                              ),
                              SizedBox(height: 16),
                              SeeAllView(
                                context: context,
                                name:
                                "${AppLocalizations.of(context)!.bestDeals} 🔥",
                                onTapAction: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.bestDealsAdaptive,
                                    arguments: bestDeals,
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              BestDealsProductList(bestDeals: bestDeals),
                              SizedBox(height: 12),
                              AutoSizeText(
                                AppConstants.version,
                                style: getSemiBoldStyle(
                                  color: ColorManager.grey,
                                  fontSize: 12,
                                ),
                              ),

                              SizedBox(height: 75),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state is HomeLoading) {
                  return SkeHome();
                }
                if (state is HomeFail) {

                }

                return CustomErrorWidget();

              },
            ),
          ),
        ),
      ),
    );


  }
}


class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error,size: 30,color: ColorManager.red,),
        Text('حدث خطاء',style: getSemiBoldStyle(color: ColorManager.red,fontSize: 20),),
      ],
    ));
  }
}
