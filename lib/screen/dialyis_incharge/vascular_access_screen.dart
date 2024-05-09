import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/screen/dialyis_incharge/dialyzer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/http_client_request.dart';
import '../../models/dialysis_settings_model/dialysis_settings_model.dart';


class VascularAccessScreen extends StatefulWidget {
  const VascularAccessScreen({super.key});

  @override
  State<VascularAccessScreen> createState() => _VascularAccessScreenState();
}

class _VascularAccessScreenState extends State<VascularAccessScreen> {




  var selectedVascularText;
  int _selectedIndex=0;

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
        selectedVascularText=settings.vascularAccess!.first.value.toString();
        loading=false;
      });
    }
    else
    {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Vascular Access'),
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
      body: (loading)?Center(child: CircularProgressIndicator(),):Column(
        children: [
          DesignConfig.space(h: 20),
          Center(
            child: Column(
              children: [
                SvgPicture.asset('assets/svg/vascular.svg'),
                CustomText(text: 'Please select')
              ],
            ),
          ),
          DesignConfig.space(h: 40),
          vasularWidget(),
        ],
      ),
    );
  }

  Widget vasularWidget(){
    return Expanded(
        child: GridView.builder(
          itemCount: settings.vascularAccess!.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 8.0,
              mainAxisExtent: 40,// spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ), itemBuilder: (context,index){
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFBBBBBB),
              blurStyle: BlurStyle.outer,
              blurRadius: 1
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomText(text: settings.vascularAccess![index].value.toString()),
            Radio(value: index, groupValue: _selectedIndex, onChanged: (val){
              setState(() {
                _selectedIndex=val!;
              });
            })
          ],
        ),
      );
    }));
  }


  var httpServices=HttpClientServices();
  void startDialysisApiCall()async{
    var prefs=await SharedPreferences.getInstance();
    var res=await httpServices.startDialysisApi(appointment_id: prefs.get('appointment_id').toString(),vascular_access: settings.vascularAccess![_selectedIndex].value.toString());
    if(res!.result==true)
    {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>DialyzerScreen()));
      });
    }
  }
}
