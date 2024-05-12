import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/app_images.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/http_request.dart';
import 'package:health_care/screen/authentication_screen/otp_screen.dart';
import 'package:health_care/screen/authentication_screen/signup_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../../common/pref_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final HttpServices httpServices=HttpServices();
  final numberController=TextEditingController();
  var loginType;

  @override
  void initState() {
    // TODO: implement initState
    PrefManager.getLoginUserTypeValue().then((value){
      setState(() {
        loginType=value;
      });
    });
    super.initState();
  }

  final HttpClientServices clientRequest=HttpClientServices();

  void sendOtpApi()async{
  var prefs=await SharedPreferences.getInstance();
  print("sjhgfjdgfgdgjf===>"+prefs.get('login_type').toString());
  var res;
  if(prefs.get('login_type').toString()=="client")
    {
      res=await clientRequest.sendOtpAPi(mobileNumber: numberController.text.trim().toString());
    }
  else
    {
       res=await httpServices.sendOtpAPi(mobileNumber: numberController.text.trim().toString());
    }

    if(res!.result==true)
      {
        setState(() {
          Get.to(OtpScreen(number: numberController.text.trim().toString(),));
          // if(res!.sign_up==1)
          //   {
          //     Get.to(SignUpScreen(number: numberController.text.trim().toString(),));
          //
          //   }
          // else
          //   {
          //
          //
          //   }


        });
      }
    else
      {
        // if(res!.sign_up==1)
        // {
        //   Get.to(SignUpScreen(number: numberController.text.trim().toString(),));
        // }
        Fluttertoast.showToast(msg: res.message.toString());
      }
  }

  void validationNumber(){
    if(numberController.text.isEmpty)
      {
        Fluttertoast.showToast(msg:"Please enter mobile number..");
      }
    else
      {
        sendOtpApi();
      }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                 child: Image.asset(AppImages.doctorIcon,height: 250),
              ),
              CustomText(text: 'Join us to start searching',fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.blackColor,),
              DesignConfig.space(h: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: CustomText(text: 'Lorem ipsum, or lipsum as it is sometimes known, isdummy text used in laying out',fontWeight: FontWeight.w400,fontSize: 12,align: TextAlign.center,color: AppColors.darkGrey,),
              ),
              DesignConfig.space(h: 7.h),
              textFormWidget(),
              DesignConfig.space(h: 5.h),
              continueWith(),
              DesignConfig.space(h: 5.h),
              socialWidget(),
              DesignConfig.space(h: 5.h),
              buttonWidget(),
              DesignConfig.space(h: 1.h),
             // dottedWidget(),
              DesignConfig.space(h: 1.h),

              loginType == "client"?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: 'New User',fontWeight: FontWeight.w400,fontSize: 13,color: AppColors.blackColor,),
                  IconButton(
                    onPressed: (){
                      Get.to(SignUpScreen());
                    },
                    icon: CustomText(text: 'Sign-up here',fontWeight: FontWeight.w400,fontSize: 13,color: AppColors.primaryColor,)),
                ],
              ):Container()
              
            ],
          ),
        ),
      ),
    );
  }



  Widget textFormWidget(){
    return Container(
      height: 7.h,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.greyColor3.withOpacity(0.2),
        borderRadius: BorderRadius.circular(19)
      ),
      child: Row(
        children: [
          CustomText(text: '+91',fontWeight: FontWeight.w400,fontSize: 16,color: AppColors.blackColor,),
          DesignConfig.space(w: 4.w),
          const Padding(
            padding:  EdgeInsets.symmetric(vertical: 7),
            child:  VerticalDivider(
              thickness: 1,
              color: AppColors.blackColor,
            ),
          ),
          DesignConfig.space(w: 4.w),
          Expanded(
              child: TextFormField(
                controller: numberController,
                keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Mobile Number',
              hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: AppColors.blackColor),
              border: InputBorder.none
            ),
          ))
        ],
      ),
    );
  }

  Widget continueWith(){
    return Row(
      children: [
        const Expanded(
            flex: 2,
            child: Divider(
              color: AppColors.greyColor2,
              thickness: 1,
            )),
        DesignConfig.space(w: 5.w),
        Expanded(
          flex: 3,
            child: CustomText(text: 'or continue with',fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.dividerColor,)),
        const Expanded(
            flex: 2,
            child: Divider(
              color: AppColors.greyColor2,
              thickness: 1,
            )),
      ],

    );
  }
  Widget dottedWidget(){
    return Row(
      children: [
        const Expanded(
            flex: 2,
            child: Divider(
              color: AppColors.greyColor2,
              thickness: 1,
            )),
        DesignConfig.space(w: 5.w),
        Expanded(
            // flex: 1,
            child: CustomText(text: 'OR',fontSize: 13,fontWeight: FontWeight.w700,color: AppColors.primaryColor,)),
        const Expanded(
            flex: 2,
            child: Divider(
              color: AppColors.greyColor2,
              thickness: 1,
            )),
      ],

    );
  }
  
  Widget socialWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Container(
         alignment: Alignment.center,
         height: 8.h,
         width: 90,
         padding: const EdgeInsets.only(top: 10),
         decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor3,width: 1),
           borderRadius: BorderRadius.circular(10),
           boxShadow: [
             BoxShadow(
               color: AppColors.greyColor1.withOpacity(0.5),
               blurStyle: BlurStyle.outer,
               blurRadius: 0.2
             )
           ]
         ),
         child: SvgPicture.asset(AppImages.facebookIcon,height: 40),
       ),
        DesignConfig.space(w: 7.h),
        Container(
          alignment: Alignment.center,
          height: 8.h,
          width: 90,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.greyColor3,width: 1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: AppColors.greyColor1.withOpacity(0.5),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 0.2
                )
              ]
          ),
          child: SvgPicture.asset(AppImages.googleIcon,height: 40),
        )
      ],
    );
  }

  Widget buttonWidget(){

    return CustomUi.primaryButton('Login', (){
      validationNumber();

    }, 12, AppColors.primaryColor, AppColors.whiteColor, 14, false);
  }

}


