import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/dialyis_incharge/vascular_access_screen.dart';

import '../../common/app_bar.dart';
import '../../models/start_dialysis_model/store_start_dialysis_data.dart';

class StartDialysisBodyScreen extends StatefulWidget {
  const StartDialysisBodyScreen({super.key});

  @override
  State<StartDialysisBodyScreen> createState() => _StartDialysisBodyScreenState();
}

class _StartDialysisBodyScreenState extends State<StartDialysisBodyScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Start Dialysis'),
      bottomSheet:InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>VascularAccessScreen()));

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Image.asset('assets/images/body_image.png',height: 300,width: 300,),
          )
        ],
      ),
    );
  }
}
