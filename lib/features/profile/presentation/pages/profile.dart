import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/functions/show_auth_action_sheet.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/routes_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/utils/cashed_data_shared_preferences.dart';
import 'package:manarat_amjad/core/widgets/custom_app_bar.dart';
import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:manarat_amjad/features/profile/presentation/widgets/ske_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/resources/assets_manager.dart';
import '../widgets/profileList.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileCubit viewModel;

  @override
  void initState() {
    viewModel = getIt.get<ProfileCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "الحساب"),
      body: SingleChildScrollView(
        child: BlocProvider.value(
          value: viewModel..getProfile(),
          child: Column(
            children: [
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  // if(state is EditProfileSuccess){
                  //   viewModel.getProfile();
                  // }
                },
                builder: (context, state) {
                  if (state is ProfileSuccess) {
                    var user = state.getUserInfoEntity.user;
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                        Text(
                          user?.name ?? '',
                          style: getSemiBoldStyle(
                            color: ColorManager.secondaryColor,
                            fontSize: 16,
                          ),
                        ),
                        user?.email == ''
                            ? const SizedBox()
                            : Text(
                              user?.email ?? '',
                              style: getSemiBoldStyle(
                                color: ColorManager.secondaryColor,
                                fontSize: 16,
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                        Text(
                          user?.phone ?? '',
                          style: getSemiBoldStyle(
                            color: ColorManager.placeHolderColor2,
                            fontSize: 14,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }

                  if (state is ProfileLoading) {
                    return SkeProfile();
                  }
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 100,
                          color: ColorManager.primaryColor,
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),

              const Divider(thickness: 0.1),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                title: "الملف الشخصي",
                icon: Icons.account_circle,
                onPress: () async {
                  if (isActiveUser) {
                    showProfileOptions(context, viewModel);
                  } else {
                    final result =await  Navigator.pushNamed(
                      context,
                      RoutesManager.authScreen,
                    );

                    if (result == true ) {
                    viewModel.getProfile();
                    }
                    // showAuthActionSheet(context);
                  }
                },
              ),

              ProfileMenuWidget(
                title: "ادارة العناوين",
                icon: Icons.delivery_dining,
                onPress: () async {
                  if (isActiveUser) {
                    Navigator.pushNamed(context, RoutesManager.addressPage);
                  } else {
                    final result =await  Navigator.pushNamed(
                      context,
                      RoutesManager.authScreen,
                    );

                    if (result == true ) {
                      viewModel.getProfile();
                    }
                    // showAuthActionSheet(context);
                  }
                },
              ),
              const Divider(thickness: 0.1),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "الشروط والأحكام",
                icon: Icons.info,
                onPress: () {
                  if (kIsWeb) {
                    Navigator.pushNamed(context, RoutesManager.termsViewWeb);
                  } else {
                    Navigator.pushNamed(context, RoutesManager.termsView);
                  }
                },
              ),
              ProfileMenuWidget(
                title: "من نحن",
                icon: Icons.developer_mode_rounded,
                endIcon: false,
                onPress: () {
                  if (kIsWeb) {
                    Navigator.pushNamed(context, RoutesManager.aboutViewWeb);
                  } else {
                    Navigator.pushNamed(context, RoutesManager.aboutView);
                  }
                },
              ),
              const Divider(thickness: 0.1),
              const SizedBox(height: 10),

              const SizedBox(height: 55),
            ],
          ),
        ),
      ),
    );
  }
}

void showProfileOptions(BuildContext context, ProfileCubit viewModel) {
  showModalBottomSheet(
    context: context,
    builder:
        (context) => Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // يجعل الارتفاع يناسب المحتوى فقط
            children: [
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title:  Text("تعديل البيانات الشخصية",
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryColor,
                    fontSize: 16,
                  ),
                ),
                onTap: () async {
                  // Navigator.pop(context);
                  final result = await Navigator.pushNamed(
                    context,
                    RoutesManager.editInfoUserForm,
                  );

                  if (result == true) {
                    viewModel.getProfile();
                  }
                },
              ),

              /// TODO IN FUTURE CHANGE PASSWORD
              // ListTile(
              //   leading: const Icon(Icons.lock, color: Colors.blue),
              //   title: Text(
              //     "تغيير كلمة المرور",
              //     style: getSemiBoldStyle(
              //       color: ColorManager.primaryColor,
              //       fontSize: 16,
              //     ),
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title:  Text("تسجيل الخروج",
                  style: getSemiBoldStyle(
                    color: ColorManager.error,
                    fontSize: 16,
                  ),),
                onTap: () {
                  CacheService.clearItems();
                  isActiveUser = false;
                  viewModel.getProfile();
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
  );
}

void showMultipleLocationOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder:
        (context) => Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.blue),
                title: const Text("إضافة موقع جديد"),
                onTap: () {
                  Navigator.pop(context); // إغلاق الـ Bottom Sheet
                  // أضف التنقل إلى صفحة إضافة الموقع
                },
              ),
              ListTile(
                leading: const Icon(Icons.list, color: Colors.blue),
                title: const Text("عرض المواقع المحفوظة"),
                onTap: () {
                  Navigator.pop(context); // إغلاق الـ Bottom Sheet
                  // أضف التنقل إلى صفحة عرض المواقع المحفوظة
                },
              ),
            ],
          ),
        ),
  );
}
