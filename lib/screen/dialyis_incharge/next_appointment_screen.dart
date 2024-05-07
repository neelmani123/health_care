import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care/screen/dialyis_incharge/technical_sign_screen.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';

class NextAppointmentScreen extends StatefulWidget {
  const NextAppointmentScreen({super.key});

  @override
  State<NextAppointmentScreen> createState() => _NextAppointmentScreenState();
}

class _NextAppointmentScreenState extends State<NextAppointmentScreen> {
  @override
  final TextEditingController enter=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Next Appointment'),
      bottomSheet:InkWell(
        onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (_)=>TechnicalSignScreen()));

        },
        child: Container(
          height: 45,
          margin: const EdgeInsets.only(bottom: 30,left: 20,right: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor
          ),
          child: CustomText(text: 'Next',color: AppColors.whiteColor,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DesignConfig.space(h: 10),
            Center(
              child: SvgPicture.asset('assets/svg/remarks.svg'),
            ),
            DesignConfig.space(h: 40),
            CustomText(text: 'Remarks'),
            DesignConfig.space(h: 20),
            Container(
                height: 100,
                child: CustomUi.editBox('Enter here', enter, TextInputType.text,))

          ],
        ),
      ),
    );
  }
}