import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/app_images.dart';
import 'package:health_care/common/app_strings.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:health_care/screen/authentication_screen/login_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({super.key});

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomText(text: 'LOGO',fontSize: 48,fontWeight: FontWeight.w700,color: AppColors.primaryColor,),
            ),
            Center(
              child: CustomText(text: 'Identify Yourself!',fontSize: 19,fontWeight: FontWeight.w400,color: AppColors.primaryColor,),
            ),
            DesignConfig.space(h: 10.h),
            loginType(),
            DesignConfig.space(h: 10.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: CustomUi.primaryButton('Next', (){
                Get.to(const LoginScreen());
              }, 5, AppColors.primaryColor, AppColors.whiteColor, 14, false),
            )
          ],
        ),
      ),
    );
  }





  Widget loginType()
  {
    return Row(
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 20.h,
                width: 120,
                decoration: BoxDecoration(
                 // borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(image: AssetImage(AppImages.dialysisIcon),fit: BoxFit.cover)
                ),
              ),

             DesignConfig.space(h: 1.h),
             CustomText(text:  AppStrings.dialysis,fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)
            ],
          ),
        )),
        DesignConfig.space(w: 1.w),
        Expanded(child: Column(
          children: [
            Container(
              height: 20.h,
              width: 120,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(image: AssetImage(AppImages.patientIcon),fit: BoxFit.cover)
              ),
            ),
            DesignConfig.space(h: 1.h),
            CustomText(text:  AppStrings.patient,fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)

          ],
        ))
        
  ],
      );
  }
}
