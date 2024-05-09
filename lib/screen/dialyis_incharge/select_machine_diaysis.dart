import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/dialyis_incharge/start_dialysis_body_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_colors.dart';
import '../../common/http_client_request.dart';
import '../../common/save_start_dialysis_data.dart';
import '../../models/dialysis_settings_model/dialysis_settings_model.dart';
import '../../models/start_dialysis_model/store_start_dialysis_data.dart';

class SelectMachineScreen extends StatefulWidget {
  const SelectMachineScreen({super.key});

  @override
  State<SelectMachineScreen> createState() => _SelectMachineScreenState();
}

class _SelectMachineScreenState extends State<SelectMachineScreen> {
  DialysisSettings settings=DialysisSettings();
  bool loading=true;
  @override
  void initState() {
    // TODO: implement initState
    dialysisSettingsApi();
    super.initState();
  }

  void dialysisSettingsApi()async{
    var res=await httpServices.dialysisSettingsApi();
    if(res!.result==true)
      {
        setState(() {
          settings=res.settings!;
          loading=false;
        });
      }
    else
      {
        Fluttertoast.showToast(msg: res.message.toString());
      }
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
      body: (loading)?const Center(child: CircularProgressIndicator(),):Column(
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
        itemCount: settings.machines!.length,
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
                   image: DecorationImage(image: NetworkImage(settings.machines![index].value.toString()),fit: BoxFit.cover)
                 ),
               ),
                DesignConfig.space(h: 10),
                CustomText(text: "No. ${settings.machines![index].key.toString()}",align: TextAlign.center,)
              ],

            ),
          );
        }));
  }
  var httpServices=HttpClientServices();
  void startDialysisApiCall(var machineNo)async{
    var prefs=await SharedPreferences.getInstance();
    var res=await httpServices.startDialysisApi(appointment_id: prefs.get('appointment_id').toString(),machine_no: settings.machines![selectedIndex].key.toString());
    if(res!.result==true)
    {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>const StartDialysisBodyScreen()));
      });
    }
  }




}
