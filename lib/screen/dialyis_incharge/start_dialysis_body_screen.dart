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
  String radio1="";
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
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            //sheight: 250,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/body_image.png'),fit: BoxFit.fitHeight)
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CustomText(text: 'Right Solder'),
                         Radio(value: '1', groupValue: radio1, onChanged: (val){
                           setState(() {
                             radio1=val!;
                           });
                         }),
                       ],
                     ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Left Solder'),
                          Radio(value: '2', groupValue: radio1, onChanged: (val){
                            setState(() {
                              radio1=val!;
                            });
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Right Hand'),
                          Radio(value: '3', groupValue: radio1, onChanged: (val){
                            setState(() {
                              radio1=val!;
                            });
                          }),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Left Hand'),
                          Radio(value: '4', groupValue: radio1, onChanged: (val){
                            setState(() {
                              radio1=val!;
                            });
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                DesignConfig.space(h: 106),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(text: 'Right Lag'),
                          Radio(value: '5', groupValue: radio1, onChanged: (val){
                          setState(() {
                            radio1=val!;
                          });
                        }),],
                      ),
                      DesignConfig.space(w: 70),
                      Row(
                        children: [
                          Radio(value: '6', groupValue: radio1, onChanged: (val){
                            setState(() {
                              radio1=val!;
                            });
                          }),
                          CustomText(text: 'Left Lag'),

                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),


          // Padding(
          //   padding: const EdgeInsets.only(left: 15,right: 15),
          //   child: Image.asset('assets/images/body_image.png',height: 300,width: 300,),
          // )
        ],
      ),
    );
  }
}
