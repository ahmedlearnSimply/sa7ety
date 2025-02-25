// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  TextEditingController emailController = new TextEditingController();
  TextEditingController passWordController = new TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: "ahmed@gmai.com",
                hintStyle: getSmallStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
