import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/screen/dialyis_incharge/remarks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../../models/dialysis_settings_model/dialysis_settings_model.dart';
import '../../models/start_dialysis_model/start_dialysis_model.dart';

class InjectableScreen extends StatefulWidget {
  StartDialysisAppointment appointment;
   InjectableScreen({super.key,required this.appointment});

  @override
  State<InjectableScreen> createState() => _InjectableScreenState();
}

class _InjectableScreenState extends State<InjectableScreen> {

  DialysisSettings settings=DialysisSettings();
  List<Injectables> injectables=[];
  Injectables? injectablesData;
  bool loading=true;
  var selectedVascularText;
  var selectedName="";
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
        injectables=settings.injectables!;
        for(int i=0;i<settings.injectables!.length;i++){
          if(widget.appointment.injectable==settings.injectables![i].value)
          {
            print("=======>hgxjgfgdggf"+settings.injectables![i].value.toString());
            selectedName=settings.injectables![i].value.toString();
          }
          loading=false;
        }
        loading=false;
      });
    }
    else
    {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }


  Widget injectableDrop()
  {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFDBDBDB),width: 1)
      ),
      child: DropdownButton<Injectables>(
        underline: Container(),
        isExpanded: true,
        onChanged: (Injectables? val){
          setState(() {
            selectedName=val!.value.toString();
          });
        },
        //value: appointmentsSelect,
        hint: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(text: selectedName),
        ),
        items: injectables.map((e){
          return DropdownMenuItem<Injectables>(value: e,child: CustomText(text:e.value.toString()),);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: DesignConfig.appBar(context, double.infinity, 'Injection'),
        bottomSheet:InkWell(
          onTap: (){
                startDialysisApiCall();

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
        body: (loading)?Center(child: CircularProgressIndicator(),):Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:   Column(
                  children: [
                    SvgPicture.asset('assets/svg/injectable.svg'),
                    CustomText(text: 'If Any')
                  ],
                ),
              ),
              DesignConfig.space(h: 20),
              CustomText(text: 'Please Select'),
              DesignConfig.space(h: 20),
              injectableDrop()
            ],
          ),
        ),
      );
  }






  var httpServices = HttpClientServices();

  void startDialysisApiCall() async {
    var prefs = await SharedPreferences.getInstance();
    var res = await httpServices.startDialysisApi(
        appointment_id: prefs.get('appointment_id').toString(),
        injectible_select: selectedName.toString()
        );
    if (res!.result == true) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>RemarksScreen(appointment: res.appointment!,)));
      });
    }
  }
}
