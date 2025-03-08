// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/core/enum/user_type_enum.dart';
import 'package:sa7ety/core/functions/dialog.dart';
import 'package:sa7ety/core/functions/email_validate.dart';
import 'package:sa7ety/core/functions/naviagation.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';
import 'package:sa7ety/core/widgets/custom_button.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_event.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_state.dart';
import 'package:sa7ety/feature/auth/presentation/pages/doctor_register.dart';
import 'package:sa7ety/feature/auth/presentation/pages/login_view.dart';
import 'package:sa7ety/feature/doctor/home/home_page.dart';

class SignUp extends StatefulWidget {
  final UserType userType;
  SignUp({super.key, required this.userType});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String handleUserType() {
    return (widget.userType == UserType.doctor) ? 'دكتور' : 'مريض';
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscure = true;
  TextEditingController nameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passWordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            showLoadingDialog(context);
          } else if (state is RegisterSuccessState) {
            if (widget.userType == UserType.doctor) {
              pushAndRemoveUntil(context, DoctorRegister());
            } else {
              // pushAndRemoveUntil(context, HomePage());
            }
            log("Success");
          } else if (state is AuthError) {
            Navigator.pop(context);
            showErrorDialog(context, state.message);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      width: 200,
                      AppAssets.logoPng,
                    ),
                    Text(
                      "سجل حساب جديد كــ ${handleUserType()}",
                      style: getTitleStyle(
                        fontSize: 23,
                      ),
                    ),
                    Gap(30),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "من فضلك ادخل الاسم";
                        } else {
                          return null;
                        }
                      },
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      textDirection:
                          TextDirection.rtl, // Force left-to-right text input
                      style: getBodyStyle(fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        fillColor: AppColors.accentColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "الاسم",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: getSmallStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 10),
                          child: Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    // Email field (LTR input)
                    TextFormField(
                      style: getBodyStyle(fontSize: 18),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "من فضلك ادخل الايميل";
                        } else if (!emailValidate(value)) {
                          return "من فضلك ادخل الايميل صحيحا";
                        }
                        return null;
                      },
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        fillColor: AppColors.accentColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Ahmed@example.com",
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: getSmallStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.email,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                      ),
                    ),

                    Gap(20),
                    //* password
                    TextFormField(
                      style: getBodyStyle(fontSize: 18),

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الرقم السري';
                        } else {
                          return null;
                        }
                      },
                      controller: passWordController,
                      obscureText: obscure,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      textDirection:
                          TextDirection.ltr, // Force left-to-right text input

                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        fillColor: AppColors.accentColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "*******",
                        hintTextDirection: TextDirection.ltr,
                        hintStyle: getSmallStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            icon: Icon(
                              size: 30,
                              obscure ? Icons.lock : Icons.lock_open_rounded,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    Gap(20),
                    //* login button
                    CustomButton(
                      text: "تسجيل حساب",
                      fontsize: 21,
                      radius: 30,
                      height: 60,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                RegisterEvent(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passWordController.text,
                                  userType: widget.userType,
                                ),
                              );
                        }
                      },
                    ),
                    Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "لدي حساب ؟",
                          style: getBodyStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Gap(8),
                        GestureDetector(
                          onTap: () {
                            pushReplacement(
                                context, LoginView(userType: widget.userType));
                          },
                          child: Text(
                            "سجل الدخول",
                            style: getBodyStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
