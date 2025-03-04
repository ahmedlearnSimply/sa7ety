// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:sa7ety/core/constants/specialization.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  String _specialization = specialization[0];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Gap(20),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        AppAssets.ahmed,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black26,
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color.fromARGB(255, 0, 130, 236),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //*specialization
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: [
                      Text(
                        "التخصص",
                        style: getBodyStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        isExpanded: true,
                        iconEnabledColor: AppColors.primary,
                        icon: Icon(
                          Icons.expand_circle_down_outlined,
                        ),
                        value: _specialization,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              _specialization = newValue ?? specialization[0];
                            },
                          );
                        },
                        items: specialization.map(
                          (element) {
                            return DropdownMenuItem(
                              value: element,
                              child: Text(
                                element,
                                style: getBodyStyle(
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                        ).toList()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
