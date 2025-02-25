// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sa7ety/core/enum/user_type_enum.dart';
import 'package:sa7ety/core/services/localstorage/local_storage.dart';
import 'package:sa7ety/feature/auth/presentation/pages/login_view.dart';
import 'package:sa7ety/feature/intro/splash/splash.dart';
import 'package:sa7ety/firebase_options.dart';

// import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppLocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('ar')],
      locale: Locale('ar'),
      home: Scaffold(
        body: LoginView(
          userType: UserType.doctor,
        ),
      ),
    );
  }
}
