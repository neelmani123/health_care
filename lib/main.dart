import 'package:flutter/material.dart';
import 'package:health_care/screen/onboarding_screen/onboarding_screen.dart';
import 'package:health_care/screen/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dialysis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home:ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return const SplashScreen();
          }
      )
    );
  }
}


