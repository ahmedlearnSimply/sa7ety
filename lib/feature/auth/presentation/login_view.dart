// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/core/functions/email_validate.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';
import 'package:sa7ety/core/widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscure = true;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passWordController = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    width: 200,
                    AppAssets.logoPng,
                  ),
                  Text(
                    "سجل الان كــ ",
                    style: getTitleStyle(
                      fontSize: 24,
                    ),
                  ),
                  Gap(20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "من فضلك ادخل الايميل";
                      } else if (emailValidate(value)) {
                        return "من فضلك ادخل الايميل صحيحا";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    text: "تسجيل الدخول",
                    fontsize: 21,
                    radius: 30,
                    height: 60,
                    onPressed: () {},
                  ),
                  Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ليس لدي حساب ؟",
                        style: getBodyStyle(
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                      ),
                      Gap(8),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "سجل الان",
                          style: getBodyStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
