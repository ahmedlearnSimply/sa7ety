// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/core/utils/textstyle.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            AppAssets.welcomePng,
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
              ))
        ],
      ),
    );
  }
}
