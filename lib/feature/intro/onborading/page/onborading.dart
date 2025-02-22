// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';
import 'package:sa7ety/feature/intro/onborading/model/onboradingModel.dart';

class Onborading extends StatefulWidget {
  const Onborading({super.key});

  @override
  State<Onborading> createState() => _OnboradingState();
}

class _OnboradingState extends State<Onborading> {
  PageController pageController = new PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "تخطي",
                style: getBodyStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: Onboradingmodel.onboardingPages.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    SvgPicture.asset(
                      Onboradingmodel.onboardingPages[index].image,
                      height: 300,
                    ),
                    Spacer(),
                    Text(
                      Onboradingmodel.onboardingPages[index].title,
                      style: getTitleStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Gap(20),
                    Text(
                      Onboradingmodel.onboardingPages[index].description,
                      style: getBodyStyle(),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(
                      flex: 4,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
