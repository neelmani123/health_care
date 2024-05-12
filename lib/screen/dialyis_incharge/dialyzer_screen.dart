import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/http_client_request.dart';
import '../../models/dialysis_settings_model/dialysis_settings_model.dart';
import '../../models/start_dialysis_model/start_dialysis_model.dart';
import 'dialyzer_type_screen.dart';


class DialyzerScreen extends StatefulWidget {
  StartDialysisAppointment appointment;
   DialyzerScreen({super.key,required this.appointment});

  @override
  State<DialyzerScreen> createState() => _DialyzerScreenState();
}

class _DialyzerScreenState extends State<DialyzerScreen> {




  DialysisSettings settings=DialysisSettings();
  bool loading=true;
  var selectedVascularText;
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
        //selectedVascularText=settings.dialyzers!.first.value.toString();
        loading=false;
        for(int i=0;i<settings.dialyzers!.length;i++){
          if(widget.appointment!.dialyzer==settings.dialyzers![i].value)
          {
            selectedDailyzerIndex=settings!.dialyzers![i].value.toString();
            enter.text=widget.appointment.dialyzerTypeText.toString();
          }
        }
      });
    }
    else
    {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }
  var selectedDailyzerIndex="0";
  final TextEditingController enter=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Dialyzers'),

      body: (loading)?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              DesignConfig.space(h: 20),
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/svg/dialyzers.svg'),
                    CustomText(text: 'Please select')
                  ],
                ),
              ),
              DesignConfig.space(h: 40),
              dialyzerWidget(),
              DesignConfig.space(h: 40),
              CustomText(text: 'Please Specify'),
              DesignConfig.space(h: 20),
              CustomUi.editBox('Enter here', enter, TextInputType.text,),
              DesignConfig.space(h: 70),
              InkWell(
                onTap: (){
                  // if(enter.text.isEmpty)
                  //   {
                  //     Fluttertoast.showToast(msg: 'Please enter specify...');
                  //   }
                  // else
                  //   {
                  startDialysisApiCall();

                  //}



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
              
            ],
          ),
        ),
      ),
    );
  }

  Widget dialyzerWidget(){
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
        itemCount: settings.dialyzers!.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0,
          mainAxisExtent: 35,// spacing between rows
          crossAxisSpacing: 3.0, // spacing between columns
        ), itemBuilder: (context,index){
      return InkWell(
        onTap: (){
          setState(() {
            selectedDailyzerIndex=settings!.dialyzers![index]!.value.toString();
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selectedDailyzerIndex==settings!.dialyzers![index]!.value.toString()?AppColors.primaryColor:Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xFFBBBBBB),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 1
                )
              ]
          ),
          child:   CustomText(text: settings.dialyzers![index].value.toString(),color: selectedDailyzerIndex==settings!.dialyzers![index]!.value.toString()?AppColors.whiteColor:AppColors.greyColor,),
        ),
      );
    });
  }


  var httpServices=HttpClientServices();
  void startDialysisApiCall()async{
    var prefs=await SharedPreferences.getInstance();
    var res=await httpServices.startDialysisApi(appointment_id: prefs.get('appointment_id').toString(),dialyzer: selectedDailyzerIndex,dialyzer_type_text: enter.text.toString());
    if(res!.result==true)
    {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>DialyzerTypeScreen(appointment: res!.appointment!,)));
      });
    }
  }
}
