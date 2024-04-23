import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_colors.dart';




class CustomUi {
  static Widget editBox(String hint, TextEditingController controller,
      TextInputType textInputType) {
    return Container(
      height: 8.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10.px),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor5, width: 1),
          borderRadius: BorderRadius.circular(11)),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            //contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xFFA1A1A1),
                fontWeight: FontWeight.w400)),
      ),
    );
  }

  static Widget numberEditBox(String hint, TextEditingController controller,
      TextInputType textInputType,FocusNode focusNode) {
    return Container(
      height: 6.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10.px),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor1, width: 0.98.px),
          borderRadius: BorderRadius.circular(11.78.px)),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        style: TextStyle(fontSize: 13.px,fontWeight: FontWeight.w500,color: AppColors.greyColor),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10)
        ],
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            //contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            hintStyle: TextStyle(
                fontSize: 15.71.px,
                color: AppColors.greyColor1,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  static Widget primaryButton(String text, Function onPressed,double border,Color backgroundColor,Color textColor,double fontSize,bool googleIcon) {
    if (Platform.isIOS) {
      return SizedBox(
        height: 45.px,
        width: Get.width,
        child: CupertinoButton(
          borderRadius: BorderRadius.circular(border),
          color: backgroundColor,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              //  googleIcon==true?SvgPicture.asset(AppImages.googleIcon):const SizedBox.shrink(),
              //  googleIcon==true? DesignConfig.space(w: 20.93.px):const SizedBox.shrink(),
                CustomText(
                  text: text,
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize,
                  align: TextAlign.center,
                ),
              ],
            ),
            onPressed: () {
              onPressed();
            }),
      );
    }

    return Container(
        height: 47.56.px,
        width: Get.width,
           margin: EdgeInsets.symmetric(horizontal: 7.px),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border),
              ),
              primary: backgroundColor,
            ),
            onPressed: () {
              onPressed();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               // googleIcon==true?SvgPicture.asset(AppImages.googleIcon):const SizedBox.shrink(),
               // googleIcon==true? DesignConfig.space(w: 20.93.px):const SizedBox.shrink(),
                CustomText(
                  text: text,
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize,
                )
              ],
            )));
  }

  static Widget htmlText(String text)
  {
    return HtmlWidget(text.toString());
  }
}
