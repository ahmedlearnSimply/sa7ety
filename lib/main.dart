// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sa7ety/core/services/localstorage/local_storage.dart';
import 'package:sa7ety/core/utils/app_theme.dart';
import 'package:sa7ety/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:sa7ety/feature/auth/presentation/pages/doctor_register.dart';
import 'package:sa7ety/feature/intro/splash/splash.dart';
import 'package:sa7ety/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://htpcqayebapesigmsxmj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh0cGNxYXllYmFwZXNpZ21zeG1qIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDEzMDg4OTgsImV4cCI6MjA1Njg4NDg5OH0.VyusEf1JJor6ozQ5Q5T_tZ7DZiXgMP-NcNe2hasaeUo',
  );
  await AppLocalStorage.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('ar')],
        locale: Locale('ar'),
        home: Scaffold(body: SplashScreen()),
      ),
    );
  }
}
