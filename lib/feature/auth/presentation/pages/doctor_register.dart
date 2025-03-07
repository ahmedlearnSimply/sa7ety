// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields
import 'dart:developer';
import 'dart:io'; // Required to use File
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:sa7ety/core/constants/specialization.dart';
import 'package:sa7ety/core/functions/dialog.dart';
import 'package:sa7ety/core/utils/app_assets.dart';
import 'package:sa7ety/core/utils/appcolors.dart';
import 'package:sa7ety/core/utils/textstyle.dart';
import 'package:sa7ety/feature/auth/data/doctor_model.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_event.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_state.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  String? userID;

  Future<void> _getUser() async {
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  //! for image picker
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // * Function to Pick Image from Gallery
  // 📸 Function to Pick Image from Camera or Gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // 📌 Show Dialog to Choose Camera or Gallery
  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اختار",
              style: getTitleStyle(),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text(
                "الكاميرا",
                style: getBodyStyle(),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: Colors.green),
              title: Text(
                "معرض الصور",
                style: getBodyStyle(),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  //! controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone1 = TextEditingController();
  final TextEditingController _phone2 = TextEditingController();

  //! formating date
  String _specialization = specialization[0];
  late String _startTime =
      DateFormat('hh:mm a').format(DateTime(2025, 9, 7, 10, 00));
  late String _endTime =
      DateFormat('hh:mm a').format(DateTime(2025, 9, 7, 22, 00));

  showStartTimePicker() async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      setState(() {
        _startTime = _formatTime(startTimePicked);
      });
    }
  }

  showEndTimePicker() async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
          DateTime.now().add(const Duration(minutes: 15))),
    );

    if (endTimePicked != null) {
      setState(() {
        _endTime = _formatTime(endTimePicked);
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final formattedTime = DateFormat('hh:mm a').format(
      DateTime(now.year, now.month, now.day, time.hour, time.minute),
    );
    return formattedTime;
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is DoctorRegisterSuccessState) {
          Navigator.pop(context);
        } else if (state is DoctorRegisterLoadingState) {
          showLoadingDialog(context);
        } else if (state is AuthError) {
          Navigator.pop(context);
          showErrorDialog(context, state.message);
        }
      },
      child: Scaffold(
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gap(20),
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          backgroundImage: (_image != null)
                              ? FileImage(_image!)
                              : AssetImage(
                                  AppAssets.docPng,
                                ) as ImageProvider,
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
                              child: GestureDetector(
                                onTap: _showImageSourceDialog,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Color.fromARGB(255, 0, 130, 236),
                                  size: 20,
                                ),
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
                              color: AppColors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                                  _specialization =
                                      newValue ?? specialization[0];
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
                    Gap(15),

                    //*  "نبذة تعريفية",
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "نبذة تعريفية",
                            style: getBodyStyle(
                              color: AppColors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    //* bio
                    TextFormField(
                      controller: _bio,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText:
                            'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل النبذة التعريفية';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(10),
                    Divider(thickness: 1, color: AppColors.greyColor),

                    //*  'عنوان العيادة',

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'عنوان العيادة',
                            style: getBodyStyle(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //* address
                    TextFormField(
                      controller: _address,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      decoration:
                          InputDecoration(hintText: 'مدينه الشروق - عماره ١١٤'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل النبذة التعريفية';
                        } else {
                          return null;
                        }
                      },
                    ),
                    //*  'ساعات العمل ',
                    Gap(8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ساعات العمل من ',
                              style: getSmallStyle(
                                  color: AppColors.black, fontSize: 16),
                            ),
                          ),
                          Gap(17),
                          Expanded(
                            child: Text(
                              'الي',
                              style: getSmallStyle(
                                  color: AppColors.black, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(5),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: showStartTimePicker,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: _startTime,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.watch_later_outlined,
                                          color: AppColors.primary,
                                        ),
                                        onPressed: () {
                                          showStartTimePicker();
                                        },
                                        color: Colors.black,
                                      )),
                                  readOnly: true,
                                ),
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: GestureDetector(
                                onTap: showEndTimePicker,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: _endTime,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.watch_later_outlined,
                                          color: AppColors.primary,
                                        ),
                                        onPressed: () {
                                          showEndTimePicker();
                                        },
                                        color: Colors.black,
                                      )),
                                  readOnly: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        //* phone number 1
                        Gap(20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'رقم الهاتف ١',
                                style: getBodyStyle(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phone1,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل رقم الهاتف';
                                  } else if (value!.length != 10) {
                                    return 'رقم الهاتف يجب أن يكون 10 رقما';
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '20xxxxxxxxx+',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'رقم الهاتف ٢ (اختياري)',
                                style: getBodyStyle(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phone2,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '20xxxxxxxxx+',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 25),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: AppColors.primary,
                backgroundColor: AppColors.primary,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate() && _image != null) {
                  _getUser();

                  context.read<AuthBloc>().add(
                        UpdateDoctorDataEvent(
                          doctorModel: DoctorModel(
                            uid: userID,
                            // image: profileUrl,
                            phone1: _phone1.text,
                            phone2: _phone2.text,
                            address: _address.text,
                            specialization: _specialization,
                            openHour: _startTime,
                            closeHour: _endTime,
                            bio: _bio.text,
                          ),
                        ),
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: (_image == null)
                          ? Text('من فضلك قم بتحميل صورتك الشخصية')
                          : Text(" من فضلك قم بكتابه معلوماتك"),
                    ),
                  );
                }
              },
              child: Text(
                style: getTitleStyle(
                  color: Colors.white,
                ),
                "التسجيل",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
