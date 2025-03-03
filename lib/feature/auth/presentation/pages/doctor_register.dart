// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "اكمال عمليه التسجيل",
          style: getBodyStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
