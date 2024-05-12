import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:health_care/screen/dashboard/dashboard.dart';

class SuccessfulAppointment extends StatefulWidget {
  final sms;
  const SuccessfulAppointment({super.key,this.sms});

  @override
  State<SuccessfulAppointment> createState() => _SuccessfulAppointmentState();
}

class _SuccessfulAppointmentState extends State<SuccessfulAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset('assets/svg/successful.svg',height: 100,)),
          DesignConfig.space(h: 20),
          CustomText(text: widget.sms.toString(),fontSize: 14,fontWeight: FontWeight.w500,),
          DesignConfig.space(h: 40),
          SizedBox(
            width: 200,
            child: CustomUi.primaryButton('Okay', (){
              Get.offAll(const DashBoard());
            }, 10, AppColors.primaryColor, AppColors.whiteColor, 12, false),
          )
        ],
      ),
    );
  }
}
