// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';
import 'package:sa7ety/core/widgets/custom_button.dart';
import 'package:sa7ety/feature/intro/onborading/model/onboradingModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onborading extends StatefulWidget {
  const Onborading({super.key});

  @override
  State<Onborading> createState() => _OnboradingState();
}

class _OnboradingState extends State<Onborading> {
  PageController pageController = new PageController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (pageIndex != Onboradingmodel.onboardingPages.length - 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  //*push to welcome page
                },
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
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
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
                    SizedBox(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SmoothPageIndicator(
                              controller: pageController,
                              count: Onboradingmodel.onboardingPages.length,
                              effect: ExpandingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10,
                                spacing: 5,
                                dotColor: Colors.grey,
                                activeDotColor: AppColors.primary,
                              ),
                            ),
                            Spacer(),
                            if (pageIndex ==
                                Onboradingmodel.onboardingPages.length - 1)
                              CustomButton(
                                width: 100,
                                text: "هيا بنا",
                                onPressed: () {},
                              )
                          ],
                        ),
                      ),
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
