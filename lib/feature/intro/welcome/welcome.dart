// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/core/enum/user_type_enum.dart';
import 'package:sa7ety/core/functions/naviagation.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';
import 'package:sa7ety/feature/auth/presentation/pages/login_view.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.asset(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              AppAssets.welcomePng,
            ),
          ),
          Positioned(
            top: 100,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اهلا بيك",
                  style: getTitleStyle(fontSize: 60),
                ),
                Text(
                  "سجل واحجز عند دكتورك وانت في بيتك",
                  style: getBodyStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(15),
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  )
                ],
                color: AppColors.primary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "سجل دلوقتي كـــ",
                    style: getBodyStyle(
                      fontSize: 26,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      push(context, LoginView(userType: UserType.doctor));
                    },
                    child: Container(
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: Center(
                        child: Text(
                          "دكتور",
                          style: getTitleStyle(
                            fontSize: 25,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Gap(20),
                  GestureDetector(
                    onTap: () {
                      push(context, LoginView(userType: UserType.patient));
                    },
                    child: Container(
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: Center(
                        child: Text(
                          "مريض",
                          style: getTitleStyle(
                            fontSize: 25,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
