import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_care/models/send_otp_model/client_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model/client_profile_model.dart';
import '../models/profile_model/profile_model.dart';
import '../models/send_otp_model/login_model.dart';




class PrefManager
{
   static userDataSave(LoginModel userData)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String user = jsonEncode(userData);
    sharedPreferences.setString('user_data', user);
  }


   static clientUserDataSave(ClientLoginModel userData)async{
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     String user = jsonEncode(userData);
     sharedPreferences.setString('user_data', user);
   }

   static profileDataSave(ProfileModel userData)async{
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     String user = jsonEncode(userData);
     sharedPreferences.setString('profile_data', user);
   }


/// client profile save data
   static clientProfileDataSave(ClientProfileModel userData)async{
     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     String user = jsonEncode(userData);
     sharedPreferences.setString('profile_data', user);
   }

   /// client profile retrive data
   static Future<ClientProfileModel> getClientprofileData() async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     Map<String,dynamic> userMap = jsonDecode(sharedPreferences.getString('profile_data')!);
     ClientProfileModel user = ClientProfileModel.fromJson(userMap);
     user.user;
     return user;
   }

   static Future<ProfileModel> getprofileData() async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     Map<String,dynamic> userMap = jsonDecode(sharedPreferences.getString('profile_data')!);
     ProfileModel user = ProfileModel.fromJson(userMap);
     user.user;
     return user;
   }


  static saveStringValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key,value);
  }

  static Future<String> getStingValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) !=null? myPrefs.getString(key)! : "";
  }



   static Future<String> getLoginUserTypeValue() async {
     SharedPreferences myPrefs = await SharedPreferences.getInstance();
     return myPrefs.get('login_type').toString();
   }

  static clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

  }


  static Future<LoginModel> getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String,dynamic> userMap = jsonDecode(sharedPreferences.getString('user_data')!);
    LoginModel user = LoginModel.fromJson(userMap);
    user.user;
    return user;
  }


   static Future<ClientLoginModel> getClientUserData() async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     Map<String,dynamic> userMap = jsonDecode(sharedPreferences.getString('user_data')!);
     ClientLoginModel user = ClientLoginModel.fromJson(userMap);
     user.user;
     return user;
   }

}