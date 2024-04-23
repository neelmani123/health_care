import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_images.dart';
import 'package:health_care/common/http_request.dart';
import 'package:health_care/common/pref_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../dashboard/dashboard.dart';

class OtpScreen extends StatefulWidget {
  final number;
  const OtpScreen({super.key,this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DesignConfig.space(h: 2.h),
              Center(
                  child: SvgPicture.asset(
                AppImages.otpIcon,
                height: 220,
              )),
              CustomText(
                text: 'Welcome',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
              DesignConfig.space(h: 2.h),
              CustomText(
                text:
                    'Lorem ipsum, or lipsum as it is sometimes known, isdummy text used in laying out',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                align: TextAlign.center,
                color: AppColors.darkGrey,
              ),
              DesignConfig.space(h: 2.h),
              CustomText(
                text: 'OTP Verification',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                align: TextAlign.center,
                color: AppColors.dividerColor,
              ),
              DesignConfig.space(h: 2.h),
              CustomText(
                text: 'Enter the 4-digit OTP\nsent to ',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                align: TextAlign.center,
                color: AppColors.greyColor4,
              ),
              DesignConfig.space(h: 2.h),
              CustomText(
                text: '+91${widget.number.toString()}',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                align: TextAlign.center,
                color: AppColors.dividerColor,
              ),
              DesignConfig.space(h: 2.h),
              otpFieldWidget(),
              DesignConfig.space(h: 3.h),
              buttonWidget(),
              DesignConfig.space(h: 1.h),
              CustomText(
                text: 'OTP not recieved?',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                align: TextAlign.center,
                color: AppColors.greyColor4,
              ),
              IconButton(
                onPressed: (){}, icon:  CustomText(text: 'Resend ',fontWeight: FontWeight.w500,fontSize: 15,color: AppColors.primaryColor,),),
            ],
          ),
        ),
      ),
    );
  }

  Widget otpFieldWidget(){
    return Container(
    //  height: 8.h,
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.12),
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
          )
        ]
      ),
      child:  Container(
        width: Get.width / 1.2,
        height: 80,
        padding: const EdgeInsets.only(left: 5, top: 15),
        child: PinCodeTextField(
          controller: otpController,
          length: 4,
          onCompleted: (value) => {},

          cursorColor: AppColors.blackColor,
          textStyle: const TextStyle(
              color: AppColors.blackColor, fontSize: 20),
          backgroundColor: AppColors.whiteColor,
          enableActiveFill: true,
          enablePinAutofill: true,
          keyboardType: TextInputType.number,
          autoFocus: false,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(7.85.px),
            fieldHeight: 45,
            fieldWidth: 45,
            errorBorderColor: AppColors.primaryColor,
            selectedFillColor: AppColors.greyColor3.withOpacity(0.2),
            disabledColor: AppColors.primaryColor,
            inactiveFillColor: AppColors.whiteColor.withOpacity(0.2),
            selectedColor: Colors.transparent,
            activeFillColor: AppColors.greyColor3.withOpacity(0.2),
            activeColor: Colors.transparent,
            inactiveColor: AppColors.primaryColor,
          ),
          appContext: context,
        ),
      ),
     
    );
  }
  Widget buttonWidget(){

    return CustomUi.primaryButton('Login', (){
      otpValidation();

    }, 12, AppColors.primaryColor, AppColors.whiteColor, 14, false);
  }

  final HttpServices httpServices=HttpServices();
  final otpController=TextEditingController();

  void otpValidation(){
    if(otpController.text.trim().isEmpty)
      {
        Fluttertoast.showToast(msg: 'Please enter otp..');
      }

    else
      {
        loginApi();
      }
  }
  final HttpClientServices clientRequest=HttpClientServices();
  void loginApi()async{
    var prefs=await SharedPreferences.getInstance();
    var res;
    if(prefs.get('login_type').toString()=="client")
    {
      res=await clientRequest.loginApi(number: widget.number.toString(), otp: otpController.text.trim().toString());
      if(res!.success==true)
      {
        final prefs=await SharedPreferences.getInstance();
        setState(() {
          Fluttertoast.showToast(msg: res.message.toString());
          PrefManager.clientUserDataSave(res);
          prefs.setString('user_token', res.token.toString());
          Get.offAll(const DashBoard());
        });
      }
      else
      {
        Fluttertoast.showToast(msg: res.message.toString());
      }
    }
    else
    {
      res=await httpServices.loginApi(number: widget.number.toString(), otp: otpController.text.trim().toString());
      if(res!.success==true)
      {
        final prefs=await SharedPreferences.getInstance();
        setState(() {
          Fluttertoast.showToast(msg: res.message.toString());
          PrefManager.userDataSave(res);
          prefs.setString('user_token', res.token.toString());
          Get.offAll(const DashBoard());
        });
      }
      else
      {
        Fluttertoast.showToast(msg: res.message.toString());
      }
    }

  }

}
