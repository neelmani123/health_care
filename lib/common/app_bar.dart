import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_colors.dart';
import 'app_images.dart';
import 'custom_text.dart';
import 'custom_ui.dart';


class DesignConfig {
  //Sized Boxes
  static space({double? h, double? w}) {
    return SizedBox(
      height: h,
      width: w,
    );
  }

  static Widget iosAppBar(String appTitle) {
    return CustomText(
      text: appTitle.toString(),
      color: AppColors.greyColor,
      fontWeight: FontWeight.w500,
      fontSize: 15.71.px,
    );
  }

  static Widget divider(Color color, double height, double thickness) {
    return Divider(
      color: color,
      height: height,
      thickness: thickness,
    );
  }

  static appBar(BuildContext context, double? width, String? text) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      shadowColor: Theme.of(context).colorScheme.onBackground,
      elevation: 0.5,
      centerTitle: Platform.isIOS ? true : false,
      title: CustomText(
          text: text!,
          // color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 15.71.px,
          color: AppColors.greyColor,
          fontWeight: FontWeight.w500),
    );
  }

  static void setSnackBar(
      String title, String msg, BuildContext context, bool showAction,
      {Function? onPressedAction, Duration? duration, required String type}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 6.h,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: title,
                color: AppColors.whiteColor,
                align: TextAlign.center,
                fontWeight: FontWeight.w500,
                fontSize: 10.71.px),
            DesignConfig.space(h: 1.h),
            CustomText(
                text: msg,
                color: AppColors.whiteColor,
                align: TextAlign.center,
                fontWeight: FontWeight.w500,
                fontSize: 12.71.px),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: type == "1"
          ? Colors.green
          : Theme.of(context).colorScheme.error,
      action: showAction
          ? SnackBarAction(
              label: "Retry",
              onPressed: onPressedAction as void Function(),
              textColor: AppColors.whiteColor,
            )
          : null,
      elevation: 2.0,
    ));
  }

  static showAlertDialog(
      BuildContext context,
      String title,
      String subtitle,
      Function onPressed,
      String image,
      String btnText,
      bool dismissible,
      bool imageSvg,
      String number
      )
  async {
    return showCupertinoDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (context) => CupertinoAlertDialog(

        content: Theme(
          data: ThemeData(primaryColor: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 20,
                child: CustomText(
                    text: title,
                    fontWeight: FontWeight.w500,
                    fontSize: 17.67.px,
                    align: TextAlign.center),
              ),
              DesignConfig.space(h: 2.h),
              imageSvg==true?SvgPicture.asset(image):Image.asset(image),
              DesignConfig.space(h: 2.h),
              number == ""
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 20,
                      child: CustomText(
                          text: number,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.67.px,
                          align: TextAlign.center,
                          color: AppColors.primaryColor),
                    ),
              number == "" ? const SizedBox.shrink() : DesignConfig.space(h: 2.h),
              SizedBox(
                height: 5.h,
                child: CustomText(
                    text: subtitle,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.74.px,
                    align: TextAlign.center),
              ),
              DesignConfig.space(h: 2.h),
              CustomUi.primaryButton(
                btnText,
                () {
                  onPressed();
                },
                20.42.px,
                AppColors.primaryColor,
                AppColors.whiteColor,
                13.71.px,
                false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
