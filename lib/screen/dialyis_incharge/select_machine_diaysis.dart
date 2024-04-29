import 'package:flutter/material.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/dialyis_incharge/start_dialysis_body_screen.dart';

import '../../common/app_colors.dart';

class SelectMachineScreen extends StatefulWidget {
  const SelectMachineScreen({super.key});

  @override
  State<SelectMachineScreen> createState() => _SelectMachineScreenState();
}

class _SelectMachineScreenState extends State<SelectMachineScreen> {
  List<String>machineImage=['assets/images/machine.png','assets/images/machine.png','assets/images/machine.png','assets/images/machine.png'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>StartDialysisBodyScreen()));

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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 100,
            crossAxisCount: 3),
        itemBuilder: (context,index){
          return Column(
            children: [
              Image.asset(machineImage[index].toString(),height: 70,width: 80,),
              DesignConfig.space(h: 10),
              CustomText(text: "No. 1",align: TextAlign.center,)
            ],

          );
        }));
  }




}
