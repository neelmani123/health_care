import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';

class SuccessfulAppointment extends StatefulWidget {
  const SuccessfulAppointment({super.key});

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
          CustomText(text: 'Completed',fontSize: 28,fontWeight: FontWeight.w600,),
          CustomUi.primaryButton('Okay', (){}, 10, AppColors.primaryColor, AppColors.whiteColor, 12, false)


        ],
      ),
    );
  }
}
