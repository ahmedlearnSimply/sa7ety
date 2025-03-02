// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, annotate_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sa7ety/core/functions/naviagation.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/feature/intro/onborading/model/onborading.dart';
import 'package:sa7ety/feature/intro/welcome/welcome.dart';

import '../../../core/services/localstorage/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      bool isOnboardingShown =
          AppLocalStorage.getCachedData(key: AppLocalStorage.kOnboarding) ??
              false; // ✅ Default to false if null

      if (isOnboardingShown) {
        pushReplacement(context, Welcome());
      } else {
        pushReplacement(context, Onborading());
      }
    });
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
