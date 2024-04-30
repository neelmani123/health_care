import 'package:flutter/material.dart';
import 'package:health_care/common/app_bar.dart';

import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';


class BpPlusSpoScreen extends StatefulWidget {
  const BpPlusSpoScreen({super.key});

  @override
  State<BpPlusSpoScreen> createState() => _BpPlusSpoScreenState();
}

class _BpPlusSpoScreenState extends State<BpPlusSpoScreen> {
  final TextEditingController enter=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'B.P, Pulse, Spo2(Pre)'),
      bottomSheet:InkWell(
        onTap: (){
          //   Navigator.push(context, MaterialPageRoute(builder: (_)=>DialyzerTypeScreen()));

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignConfig.space(h: 10),
              CustomText(text: 'Blood Pressure'),
              CustomUi.editBox('Enter here', enter, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Pulse'),
              CustomUi.editBox('Enter here', enter, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Spo2'),
              CustomUi.editBox('Enter here', enter, TextInputType.text,),
            ],
          ),
        ),
      ),
    );
  }


}
