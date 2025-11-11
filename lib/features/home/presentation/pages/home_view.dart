import 'package:auto_size_text/auto_size_text.dart';
import 'package:fada_alhalij_web/core/resources/app_constants.dart';
import 'package:fada_alhalij_web/core/resources/routes_manager.dart';
import 'package:fada_alhalij_web/core/widgets/custom_dialog.dart';
import 'package:fada_alhalij_web/core/widgets/custom_error_widget.dart';
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
                              _buildSectionHeader(
                                context: context,
                                title: '${AppLocalizations.of(context)!.categories} 🛍️',
                                onTap: () => LayoutCubit.get(context).changeIndex(1),
                                icon: Icons.apps_rounded,
                              ),

                              SizedBox(height: 16),
                              GridCategories(categories: categories),
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Carousel(banners: banners),
                              ),
                              SizedBox(height: 16),
                              bestDeals.isNotEmpty? _buildSectionHeader(
                                context: context,
                                title: "${AppLocalizations.of(context)!.bestDeals} 🔥",
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesManager.bestDealsAdaptive,
                                    arguments: bestDeals,
                                  );
                                },
                                icon: Icons.local_fire_department_rounded,
                              ):SizedBox(),
                              // SeeAllView(
                              //   context: context,
                              //   name:
                              //   "${AppLocalizations.of(context)!.bestDeals} 🔥",
                              //   onTapAction: () {
                              //     Navigator.pushNamed(
                              //       context,
                              //       RoutesManager.bestDealsAdaptive,
                              //       arguments: bestDeals,
                              //     );
                              //   },
                              // ),
                              SizedBox(height: 16),
                              bestDeals.isNotEmpty?   BestDealsProductList(bestDeals: bestDeals):SizedBox(),
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
  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorManager.primaryColor.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ColorManager.primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorManager.primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: ColorManager.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: getBoldStyle(
                  color: ColorManager.textColor,
                  fontSize: 18,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.primaryColor,
                        ColorManager.primaryColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.seeAll,
                        style: getSemiBoldStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}




// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:fada_alhalij_web/core/resources/app_constants.dart';
// import 'package:fada_alhalij_web/core/resources/routes_manager.dart';
// import 'package:fada_alhalij_web/features/home/presentation/widgets/custom_card.dart';
// import 'package:fada_alhalij_web/l10n/app_localizations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fada_alhalij_web/core/resources/color_manager.dart';
// import '../../../../core/di/di.dart';
// import '../../../../core/resources/style_manager.dart';
// import '../../../../core/widgets/see_all_view.dart';
// import '../../../layout/presentation/cubit/layout_cubit.dart';
// import '../../data/models/response/home_model_response_dto.dart';
// import '../cubit/home_cubit.dart';
// import '../widgets/app_bar_body.dart';
// import '../widgets/carousel.dart';
// import '../widgets/grid_categories.dart';
// import '../widgets/horizontal_product_list.dart';
// import '../widgets/search_text_filed.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
//   late HomeCubit viewModel;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   @override
//   void initState() {
//     viewModel = getIt<HomeCubit>();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));
//
//     _animationController.forward();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     viewModel.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => viewModel..getHomeData(),
//       child: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           if (state is HomeSuccess) {
//             List<Categories>? categories =
//                 state.homeEntity?.data?.category?.categories ?? [];
//             List<ProductsBestDeals>? bestDeals =
//                 state.homeEntity?.data?.bestDeals?.productsBestDeals?.reversed
//                     .toList() ??
//                     [];
//             Store? store = state.homeEntity?.data!.store;
//             List<Banners> banners =
//                 state.homeEntity?.data?.banner?.banners ?? [];
//             List<Discounts>? discount = state.homeEntity?.data?.discount?.discounts ?? [];
//
//             return GestureDetector(
//               onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//               child: Scaffold(
//                 body: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         ColorManager.white,
//                         ColorManager.backgroundColor.withOpacity(0.3),
//                         ColorManager.white,
//                       ],
//                       stops: const [0.0, 0.5, 1.0],
//                     ),
//                   ),
//                   child: NestedScrollView(
//                     headerSliverBuilder: (context, innerBoxIsScrolled) {
//                       return [AppBarBody(store: store)];
//                     },
//                     body: RefreshIndicator(
//                       color: ColorManager.primaryColor,
//                       backgroundColor: Colors.white,
//                       strokeWidth: 3,
//                       onRefresh: () async {
//                         await viewModel.getHomeData();
//                         _animationController.reset();
//                         _animationController.forward();
//                       },
//                       child: SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: SlideTransition(
//                             position: _slideAnimation,
//                             child: Column(
//                               children: [
//                                 // بطاقة الخصومات المحسنة
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 12,
//                                   ),
//                                   child: Hero(
//                                     tag: 'discount_card',
//                                     child: Material(
//                                       color: Colors.transparent,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(20),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: ColorManager.primaryColor.withOpacity(0.2),
//                                               blurRadius: 15,
//                                               offset: const Offset(0, 5),
//                                             ),
//                                           ],
//                                         ),
//                                         child: CustomCard(discounts: discount),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 24),
//
//                                 // قسم الأقسام مع تحسينات
//                                 _buildSectionHeader(
//                                   context: context,
//                                   title: '${AppLocalizations.of(context)!.categories} 🛍️',
//                                   onTap: () => LayoutCubit.get(context).changeIndex(2),
//                                   icon: Icons.apps_rounded,
//                                 ),
//
//                                 const SizedBox(height: 16),
//
//                                 // شبكة الأقسام المحسنة
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(16),
//                                       color: Colors.white.withOpacity(0.7),
//                                     ),
//                                     padding: const EdgeInsets.all(8),
//                                     child: GridCategories(categories: categories),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 24),
//
//                                 // البانر المحسن
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.08),
//                                           blurRadius: 20,
//                                           offset: const Offset(0, 8),
//                                         ),
//                                       ],
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(20),
//                                       child: Carousel(banners: banners),
//                                     ),
//                                   ),
//                                 ),
//
//                                 const SizedBox(height: 32),
//
//                                 // قسم العروض الساخنة
//                                 _buildSectionHeader(
//                                   context: context,
//                                   title: "${AppLocalizations.of(context)!.bestDeals} 🔥",
//                                   onTap: () {
//                                     Navigator.pushNamed(
//                                       context,
//                                       RoutesManager.bestDealsAdaptive,
//                                     );
//                                   },
//                                   icon: Icons.local_fire_department_rounded,
//                                 ),
//
//                                 const SizedBox(height: 16),
//
//                                 // قائمة المنتجات المحسنة
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topCenter,
//                                       end: Alignment.bottomCenter,
//                                       colors: [
//                                         Colors.white.withOpacity(0.5),
//                                         Colors.transparent,
//                                       ],
//                                     ),
//                                   ),
//                                   child: BestDealsProductList(bestDeals: bestDeals),
//                                 ),
//
//                                 const SizedBox(height: 24),
//                                 SizedBox(height: 75),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }
//
//           // حالة التحميل المحسنة
//           return Scaffold(
//             body: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     ColorManager.primaryColor.withOpacity(0.1),
//                     ColorManager.white,
//                     ColorManager.secondaryColor.withOpacity(0.05),
//                   ],
//                 ),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: ColorManager.primaryColor.withOpacity(0.2),
//                             blurRadius: 20,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           ColorManager.primaryColor,
//                         ),
//                         strokeWidth: 3,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       AppLocalizations.of(context)!.waiting,
//                       style: getSemiBoldStyle(
//                         color: ColorManager.primaryColor,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ويدجت مخصص لعناوين الأقسام
//   Widget _buildSectionHeader({
//     required BuildContext context,
//     required String title,
//     required VoidCallback onTap,
//     required IconData icon,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               ColorManager.primaryColor.withOpacity(0.1),
//               Colors.transparent,
//             ],
//           ),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: ColorManager.primaryColor.withOpacity(0.2),
//             width: 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: ColorManager.primaryColor.withOpacity(0.15),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 icon,
//                 color: ColorManager.primaryColor,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 title,
//                 style: getBoldStyle(
//                   color: ColorManager.textColor,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: onTap,
//                 borderRadius: BorderRadius.circular(20),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         ColorManager.primaryColor,
//                         ColorManager.primaryColor.withOpacity(0.8),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: ColorManager.primaryColor.withOpacity(0.3),
//                         blurRadius: 8,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         AppLocalizations.of(context)!.seeAll,
//                         style: getSemiBoldStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       const Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         color: Colors.white,
//                         size: 14,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }