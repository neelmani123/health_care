import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/dialyis_incharge/start_dialysis_body_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_colors.dart';
import '../../common/http_client_request.dart';
import '../../common/save_start_dialysis_data.dart';
import '../../models/start_dialysis_model/store_start_dialysis_data.dart';

class SelectMachineScreen extends StatefulWidget {
  const SelectMachineScreen({super.key});

  @override
  State<SelectMachineScreen> createState() => _SelectMachineScreenState();
}

class _SelectMachineScreenState extends State<SelectMachineScreen> {
  List<String>machineImage=['assets/images/machine.png','assets/images/machine.png','assets/images/machine.png','assets/images/machine.png'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:InkWell(
        onTap: (){
          startDialysisApiCall(selectedIndex.toString());

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
      appBar: DesignConfig.appBar(context, double.infinity, 'Select Machine No'),
      body: Column(
        children: [
          DesignConfig.space(h: 30),
          Center(
            child: CustomText(text: 'Machine No :-',fontWeight: FontWeight.w500,fontSize: 16,),
          ),
          DesignConfig.space(h: 30),
          machineWidget(),

        ],
      ),
    );
  }
  
  
  
  
  Widget machineWidget(){
    return Expanded(
        child: GridView.builder(
          shrinkWrap: true,
        itemCount: machineImage.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 100,
            crossAxisCount: 3),
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              setState(() {
                setState(() {
                  selectedIndex=index;
                });
              });
            },
            child: Column(
              children: [
               Container(
                 height: 70,
                 margin: EdgeInsets.symmetric(horizontal: 15),
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   border: Border.all(color: selectedIndex==index?AppColors.primaryColor:Colors.transparent, width: 3),
                   image: DecorationImage(image: AssetImage(machineImage[index].toString()),fit: BoxFit.cover)
                 ),
               ),
                DesignConfig.space(h: 10),
                CustomText(text: "No. 1",align: TextAlign.center,)
              ],

            ),
          );
        }));
  }
  var httpServices=HttpClientServices();
  void startDialysisApiCall(var machineNo)async{
    var prefs=await SharedPreferences.getInstance();
    var res=await httpServices.startDialysisApi(appointment_id: prefs.get('appointment_id').toString(),machine_no: machineNo.toString());
    if(res!.result==true)
    {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const StartDialysisBodyScreen()));
      });
    }
  }




}
