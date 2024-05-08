import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../dashboard/dashboard.dart';

class HeamodialysisOrdersScreen extends StatefulWidget {
  const HeamodialysisOrdersScreen({super.key});

  @override
  State<HeamodialysisOrdersScreen> createState() => _HeamodialysisOrdersScreenState();
}

class _HeamodialysisOrdersScreenState extends State<HeamodialysisOrdersScreen> {
  final TextEditingController duration=TextEditingController();
  final TextEditingController Heparinunit=TextEditingController();
  final TextEditingController MeanBloodFlow=TextEditingController();
  final TextEditingController PreDialysisWeight=TextEditingController();
  final TextEditingController PostDialysisWeight=TextEditingController();
  final TextEditingController TotalUFGoal=TextEditingController();
  String dialysisSolution = '',conductivity='';
  String selectedDialysisSolution="-Bicarb",selectedConductivity='Low';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Heamodialysis Orders'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DesignConfig.space(h: 10),
              CustomText(text: 'Duration'),
              CustomUi.editBox('Duration', duration, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Heparin unit'),
              CustomUi.editBox('mg/ml', Heparinunit, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Mean Blood Flow'),
              CustomUi.editBox('Mean Blood Flow', MeanBloodFlow, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Dialysis Solution'),
              DesignConfig.space(h: 10),
              Row(
                children: [
                  Radio(value: '1', groupValue: dialysisSolution, onChanged: (val){
                    setState(() {
                      dialysisSolution=val!;
                      selectedDialysisSolution='-Bicarb';
                    });
                  }),
                  CustomText(text: '-Bicarb'),
                  Radio(value: '2', groupValue: dialysisSolution, onChanged: (val){
                    setState(() {
                      dialysisSolution=val!;
                      selectedDialysisSolution='K+ Free';
                    });
                  }),
                  CustomText(text: 'K+ Free'),
                  Radio(value: '3', groupValue: dialysisSolution, onChanged: (val){
                    setState(() {
                      dialysisSolution=val!;
                      selectedDialysisSolution='ca++ Free';
                    });
                  }),
                  CustomText(text: 'ca++ Free'),
                ],
              ),
              DesignConfig.space(h: 10),
              CustomText(text: 'Pre Dialysis Weight'),
              CustomUi.editBox('Pre Dialysis Weight', PreDialysisWeight, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Post Dialysis Weight'),
              CustomUi.editBox('Post Dialysis Weight', PostDialysisWeight, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Total UF Goal'),
              CustomUi.editBox('Total UF Goal', TotalUFGoal, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Conductivity'),
              DesignConfig.space(h: 10),
              Row(
                children: [
                  Radio(value: '1', groupValue: conductivity, onChanged: (val){
                    setState(() {
                      conductivity=val!;
                      selectedConductivity='Low';
                    });
                  }),
                  CustomText(text: 'Low'),
                  Radio(value: '2', groupValue: conductivity, onChanged: (val){
                    setState(() {
                      conductivity=val!;
                      selectedConductivity='Standard';
                    });
                  }),
                  CustomText(text: 'Standard'),
                  Radio(value: '3', groupValue: conductivity, onChanged: (val){
                    setState(() {
                      conductivity=val!;
                      selectedConductivity='High';
                    });
                  }),
                  CustomText(text: 'High'),
                ],
              ),
              DesignConfig.space(h: 50),
              InkWell(
                onTap: (){
                  if(duration.text.isEmpty)
                  {
                    Fluttertoast.showToast(msg: 'Please enter duration...');
                  }
                  else if(Heparinunit.text.isEmpty)
                  {
                    Fluttertoast.showToast(msg: 'Please enter heparin unit...');
                  }
                  else if(MeanBloodFlow.text.isEmpty)
                  {
                    Fluttertoast.showToast(msg: 'Please enter mean blood flow ...');
                  }
                  else if(PreDialysisWeight.text.isEmpty)
                  {
                    Fluttertoast.showToast(msg: 'Please enter pre dialysis weight ...');
                  }
                  else if(PostDialysisWeight.text.isEmpty)
                  {
                    Fluttertoast.showToast(msg: 'Please enter post dialysis weight ...');
                  }
                  else if(TotalUFGoal.text.isEmpty)
                  {
                    Fluttertoast.showToast(msg: 'Please enter total UF goal ...');
                  }
                  else{
                    startDialysisApiCall();
                  }

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
              )
            ],
          ),
        ),
      ),
    );
  }


  var httpServices = HttpClientServices();

  void startDialysisApiCall() async {
    var prefs = await SharedPreferences.getInstance();
    var res = await httpServices.startDialysisApi(
        appointment_id: prefs.get('appointment_id').toString(),
      duration: duration.text.toString(),
      heperin_unit: Heparinunit.text.toString(),
      mean_blood_flow: MeanBloodFlow.text.toString(),
      dialysis_solution: selectedDialysisSolution.toString(),
      pre_dialysis_weight: PreDialysisWeight.text.toString(),
        post_dialysis_weight: PostDialysisWeight.text.toString(),
      total_uf_goal: TotalUFGoal.text.toString(),
      conductivity: selectedConductivity.toString()
    );
    if (res!.result == true) {
      setState(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashBoard()),
              (Route<dynamic> route) => false,
        );

      });
    }
}
}
