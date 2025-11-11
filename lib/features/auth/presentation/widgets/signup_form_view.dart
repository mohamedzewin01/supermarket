import 'package:manarat_amjad/core/widgets/custom_elevated_button.dart';
import 'package:manarat_amjad/core/widgets/custom_text_form_field.dart';
import 'package:manarat_amjad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/color_manager.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, required this.viewModel});

  final AuthCubit viewModel;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureRePassword = true;



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          CustomTextFormField(
            isRequired: true,
            controller: widget.viewModel.nameController,
            labelText: "الاسم",
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
            controller: widget.viewModel.emailController,
            labelText: "الايميل",
            keyboardType: TextInputType.emailAddress,
          ),
          Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus && widget.viewModel.phoneController.text.isEmpty) {
                widget.viewModel.phoneController.text = '+966';
              }
            },
            child: CustomTextFormField(
              isRequired: true,
              controller: widget.viewModel.phoneController,
              textDirection: TextDirection.ltr,
              labelText: "رقم الجوال",
              hintText: "+9665XXXXXXXX",
              keyboardType: TextInputType.phone,
              onTap: () {
                if (!widget.viewModel.phoneController.text.startsWith('+966')) {
                  widget.viewModel.phoneController.text = '+966';
                  widget.viewModel.phoneController.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.viewModel.phoneController.text.length),
                  );
                }
              },
              onChanged: (value) {
                if (!value.startsWith('+966')) {
                  final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
                  final newText = '+966${cleaned.replaceFirst(RegExp(r'^966*'), '').replaceFirst(RegExp(r'^0'), '')}';
                  widget.viewModel.phoneController.text = newText;
                  widget.viewModel.phoneController.selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.viewModel.phoneController.text.length),
                  );
                } else {
                  if (value.length > 4 && value[4] == '0') {
                    final newText = value.substring(0, 4) + value.substring(5);
                    widget.viewModel.phoneController.text = newText;
                    widget.viewModel.phoneController.selection = TextSelection.fromPosition(
                      TextPosition(offset: newText.length),
                    );
                  }
                }

                // الحد الأقصى للطول: +966 + 9 أرقام = 13
                if (widget.viewModel.phoneController.text.length > 13) {
                  final text = widget.viewModel.phoneController.text.substring(0, 13);
                  widget.viewModel.phoneController.text = text;
                  widget.viewModel.phoneController.selection = TextSelection.fromPosition(
                    TextPosition(offset: text.length),
                  );
                }
              },

              validator: (value) {
                if (value == null || value.trim().isEmpty || value == '+966') {
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
          CustomTextFormField(
            isRequired: true,
            controller: widget.viewModel.passwordController,
            labelText: "كلمة المرور",
            hintText: "ادخل كلمة المرور",
            textDirection: TextDirection.ltr,
            isPassword: true,
            obscureText: _obscurePassword,
            onToggle: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'كلمة المرور قصيرة';
              }
              return null;

            },
          ),
          CustomTextFormField(
            isRequired: true,
            controller: widget.viewModel.rePasswordController,
            labelText: "تأكيد كلمة المرور",
            hintText: "تاكيد كلمة المرور",
            textDirection: TextDirection.ltr,
            isPassword: true,
            obscureText: _obscureRePassword,
            onToggle: () {
              setState(() => _obscureRePassword = !_obscureRePassword);
            },
            validator: (value) {
              if (value != widget.viewModel.passwordController.text) {
                return 'كلمة المرور غير متطابقة';
              }
              return null;
            },
          ),
          CustomElevatedButton(
            onPressed: _submit,
            buttonColor: ColorManager.primaryColor,
            title: 'تسجيل جديد',
          ),

        ],
      ),
    );
  }
  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.viewModel.signUp();
    }
  }
}
