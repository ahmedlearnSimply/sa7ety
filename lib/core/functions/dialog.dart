// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'dart:ui';

import 'package:sa7ety/core/utils/textstyle.dart';

showErrorDialog(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.redColor,
    content: Text(
      text,
      style: getSmallStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  ));
}

showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/loading.json',
                width: 200,
                height: 200,
              ),
            ],
          ));
}
