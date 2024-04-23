import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_care/common/pref_manager.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../screen/authentication_screen/login_screen.dart';



class ApiBaseClient
{

  String appDoctorMainUrl="https://client.kidneymitr.com/api/v1/";
  PrefManager prefManager=PrefManager();

  Future<String> getToken() async {
    var token="";
    await PrefManager.getClientUserData().then((value) => {
      debugPrint("Token------------>${value.token}",wrapWidth: 5000),
      token= value.token!,
    });
    return token;
  }

  Future <Map<String, String>> getDefaultHeadersToken() async{
    var token=await getToken();
    Map<String, String> defaultHeaders = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization":"Bearer ${token}"
    };
    return defaultHeaders;
  }

  Future<dynamic> postApi(String url, Map<String, dynamic> reqBody) async {
    var responseJson;
    debugPrint("data==>$reqBody", wrapWidth: 1024);
    debugPrint("data==>$appDoctorMainUrl$url");

    final response = await http
        .post(Uri.parse(appDoctorMainUrl + url), body: jsonEncode(reqBody), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    debugPrint("data==>${response.body}", wrapWidth: 1024);
    try {
      responseJson = _returnResponse(response);
      return responseJson;
    } catch (e) {
      debugPrint("===$e");
      e.toString();
    }
  }

  Future<dynamic>getApi(String url,Map<String,dynamic> reqBody)async
  {
    var headers=<String, String>{};
    await getDefaultHeadersToken().then((value) =>
    {
      headers=value
    });
    var responseJson;
    debugPrint("data==>$reqBody", wrapWidth: 1024);
    debugPrint("data==>$appDoctorMainUrl$url");
    debugPrint("data==>$headers");
    final response=await http.get(Uri.parse(appDoctorMainUrl+url),headers: headers);
    try {
      responseJson = _returnResponse(response);
      return responseJson;
    } catch (e) {
      debugPrint("===$e");
      e.toString();
    }

  }


  Future<dynamic>postBearerApi(String url,Map<String,dynamic> reqBody)async
  {
    var headers=<String, String>{};
    await getDefaultHeadersToken().then((value) =>
    {
      headers=value
    });
    var responseJson;
    debugPrint("data==>$reqBody", wrapWidth: 1024);
    debugPrint("Url==>$appDoctorMainUrl$url");
    debugPrint("Heards==>$headers");
    final response=await http.post(Uri.parse(appDoctorMainUrl+url),headers: headers,body: jsonEncode(reqBody));
    try {
      debugPrint("Response is=========>${response.body}",wrapWidth: 1024);
      responseJson = _returnResponse(response);
      return responseJson;
    } catch (e) {
      debugPrint("===$e");
      e.toString();
    }

  }


  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        authFailure();
        return null;
      case 400:
        statusCodeUnauth();
        return null;
      default:
        return null;
    }
  }
  authFailure() {}
  statusCodeUnauth(){
    Get.offAll(const LoginScreen());
  }
}