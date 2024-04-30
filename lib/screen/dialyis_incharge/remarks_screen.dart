import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import 'next_appointment_screen.dart';




class RemarksScreen extends StatefulWidget {
  const RemarksScreen({super.key});

  @override
  State<RemarksScreen> createState() => _RemarksScreenState();
}

class _RemarksScreenState extends State<RemarksScreen> {
  final TextEditingController enter=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Remarks'),
      bottomSheet:InkWell(
        onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (_)=>NextAppointmentScreen()));

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
