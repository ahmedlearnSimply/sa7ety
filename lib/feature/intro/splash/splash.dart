// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sa7ety/core/functions/naviagation.dart';
import 'package:sa7ety/core/services/localstorage/local_storage.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/feature/intro/onborading/page/onborading.dart';
import 'package:sa7ety/feature/intro/welcome/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      bool isOnboradingShown =
          AppLocalStorage.getCachedData(key: AppLocalStorage.kOnboarding) ==
              true;
      if (isOnboradingShown) {
        pushReplacement(context, Welcome());
      } else {
        pushReplacement(context, Onborading());
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        height: 250,
        child: Image.asset(
          AppAssets.logoPng,
        ),
      ),
    );
  }
}
