import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sa7ety/core/services/localstorage/local_storage.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
