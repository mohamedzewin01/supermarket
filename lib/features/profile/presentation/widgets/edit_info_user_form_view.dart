import 'package:manarat_amjad/core/di/di.dart';
import 'package:manarat_amjad/core/resources/color_manager.dart';
import 'package:manarat_amjad/core/resources/style_manager.dart';
import 'package:manarat_amjad/core/widgets/custom_dialog.dart';
import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/core/widgets/custom_sliver_app_bar.dart';
import 'package:manarat_amjad/core/widgets/custom_text_form_field.dart';
import 'package:manarat_amjad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:manarat_amjad/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:manarat_amjad/features/profile/data/models/response/get_user_info_dto.dart';
import 'package:manarat_amjad/features/profile/presentation/cubit/profile_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EditInfoUserForm extends StatefulWidget {
  const EditInfoUserForm({super.key});

  @override
  State<EditInfoUserForm> createState() => _EditInfoUserFormState();
}

class _EditInfoUserFormState extends State<EditInfoUserForm> {
  late ProfileCubit viewModel;

  final _formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    viewModel = getIt.get<ProfileCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel..getProfile(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              title: 'تعديل بيانات المستخدم',
              isBack: true,
              onBackTap: () {

                Navigator.pop(context);
              },
            ),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  CustomDialog.showSuccessDialog(
                    context,
                    message: 'تم تعديل البيانات بنجاح',
                    onDialogClose: () {
                      viewModel.getProfile();
                    },
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return SliverToBoxAdapter(
                    child: Skeletonizer(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 16.0,
                          children: [
                            SizedBox(height: 50,),
                            Text(
                              ' تعديل البيانات الشخصية',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            CustomTextFormField(
                              controller:TextEditingController(),
                              isRequired: true,
                              labelText: 'الاسم ',
                            ),

                            CustomTextFormField(
                              controller:TextEditingController(),
                              labelText: "الايميل",

                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomTextFormField(
                              controller:TextEditingController(),
                              isRequired: true,
                              textDirection: TextDirection.ltr,
                              labelText: "رقم الجوال",
                              hintText: "+9665XXXXXXXX",
                              keyboardType: TextInputType.phone,
                            ),

                            CustomElevatedButton(
                              onPressed: (){},
                              buttonColor: ColorManager.primaryColor,
                              title: 'تعديل',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state is ProfileSuccess) {
                  ProfileUser? user=state.getUserInfoEntity.user;
                  nameController.text=user?.name??'';
                  emailController.text=user?.email??'';
                  phoneController.text=user?.phone??'';
                  return SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          spacing: 16.0,
                          children: [
                            SizedBox(height: 50,),
                            Text(
                              ' تعديل البيانات الشخصية',
                              style: getSemiBoldStyle(
                                color: ColorManager.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            CustomTextFormField(
                              controller: nameController,
                              isRequired: true,
                              labelText: 'الاسم ',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'الاسم مطلوب';
                                }
                                if (value.trim().length < 5) {
                                  return 'الاسم يجب أن يكون 5 حروف أو أكثر';
                                }
                                final regex = RegExp(r"^[\u0621-\u064A\s]+$");
                                if (!regex.hasMatch(value.trim())) {
                                  return 'الاسم يجب أن يحتوي على حروف عربية فقط';
                                }
                                return null;
                              },
                            ),

                            CustomTextFormField(
                              controller: emailController,
                              labelText: "الايميل",

                              keyboardType: TextInputType.emailAddress,
                            ),
                            Focus(
                              onFocusChange: (hasFocus) {
                                if (hasFocus &&
                                    phoneController.text.isEmpty) {
                                  phoneController.text = '+966';
                                }
                              },
                              child: CustomTextFormField(
                                controller: phoneController,
                                isRequired: true,
                                textDirection: TextDirection.ltr,
                                labelText: "رقم الجوال",
                                hintText: "+9665XXXXXXXX",
                                keyboardType: TextInputType.phone,
                                onTap: () {
                                  if (!phoneController.text
                                      .startsWith('+966')) {
                                    phoneController.text = '+966';
                                    phoneController
                                        .selection = TextSelection.fromPosition(
                                      TextPosition(
                                        offset:
                                        phoneController
                                            .text
                                            .length,
                                      ),
                                    );
                                  }
                                },
                                onChanged: (value) {
                                  if (!value.startsWith('+966')) {
                                    final cleaned = value.replaceAll(
                                      RegExp(r'[^\d]'),
                                      '',
                                    );
                                    final newText =
                                        '+966${cleaned.replaceFirst(RegExp(r'^966*'), '').replaceFirst(RegExp(r'^0'), '')}';
                                    phoneController.text = newText;
                                    phoneController
                                        .selection = TextSelection.fromPosition(
                                      TextPosition(
                                        offset:
                                        phoneController
                                            .text
                                            .length,
                                      ),
                                    );
                                  } else {
                                    if (value.length > 4 && value[4] == '0') {
                                      final newText =
                                          value.substring(0, 4) +
                                              value.substring(5);
                                      phoneController.text = newText;
                                      phoneController
                                          .selection = TextSelection.fromPosition(
                                        TextPosition(offset: newText.length),
                                      );
                                    }
                                  }

                                  // الحد الأقصى للطول: +966 + 9 أرقام = 13
                                  if (phoneController.text.length >
                                      13) {
                                    final text = phoneController.text
                                        .substring(0, 13);
                                    phoneController.text = text;

                                    phoneController
                                        .selection = TextSelection.fromPosition(
                                      TextPosition(offset: text.length),
                                    );
                                  }
                                },

                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value == '+966') {
                                    return 'رقم الجوال مطلوب';
                                  }
                                  if (!value.startsWith('+966')) {
                                    return 'رقم الهاتف يجب أن يبدأ بـ +966';
                                  }
                                  if (value.length != 13) {
                                    return 'رقم الهاتف يجب أن يحتوي على 9 أرقام بعد +966';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            CustomElevatedButton(
                              onPressed: _submit,
                              buttonColor: ColorManager.primaryColor,
                              title: 'تعديل',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SliverToBoxAdapter(child: Container());
              },




            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      viewModel.editProfile(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
    }
  }
}

// CustomTextFormField(
// controller: TextEditingController(),
// labelText: "كلمة المرور",
// hintText: "ادخل كلمة المرور",
// textDirection: TextDirection.ltr,
// isPassword: true,
// obscureText: _obscurePassword,
// onToggle: () {
// setState(() => _obscurePassword = !_obscurePassword);
// },
// validator: (value) {
// if (value == null || value.length < 6) {
// return 'كلمة المرور قصيرة';
// }
// return null;
// },
// ),
// CustomTextFormField(
// controller: TextEditingController(),
// labelText: "تأكيد كلمة المرور",
// hintText: "تاكيد كلمة المرور",
// textDirection: TextDirection.ltr,
// isPassword: true,
// obscureText: _obscureRePassword,
// onToggle: () {
// setState(
// () => _obscureRePassword = !_obscureRePassword,
// );
// },
// validator: (value) {
// // if (value != viewModel.passwordController.text) {
// //   return 'كلمة المرور غير متطابقة';
// // }
// // return null;
// },
// ),
