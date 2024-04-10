import 'package:flutter/material.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/pref_manager.dart';
import 'package:health_care/screen/authentication_screen/identity_screen.dart';
import 'package:health_care/screen/dashboard/dashboard.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  void startTimer() {
    Timer(const Duration(seconds: 2), () => navigate());
  }

  void navigate() async {
    final prefs=await SharedPreferences.getInstance();
  print("Token============+++++>"+prefs.get('user_token').toString());

    if(prefs.get('user_token')!=null){
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) =>  const OnBoardingScreen()),
      //       (Route<dynamic> route) => false,
      // );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashBoard()),
            (Route<dynamic> route) => false,
      );
    }
    else
    {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  const OnBoardingScreen()),
            (Route<dynamic> route) => false,
      );

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor
        ),
      ),
    );
  }
}
