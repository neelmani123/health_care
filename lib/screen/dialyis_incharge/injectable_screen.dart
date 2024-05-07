import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_care/screen/dialyis_incharge/remarks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';

class InjectableScreen extends StatefulWidget {
  const InjectableScreen({super.key});

  @override
  State<InjectableScreen> createState() => _InjectableScreenState();
}

class _InjectableScreenState extends State<InjectableScreen> {

  List<String> dropItem=["Ravi Kumar","Ravi Kumar","Ravi Kumar"];
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
        body: Padding(
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
              consultantDrop(),
            ],
          ),
        ),
      );
  }



  Widget consultantDrop()
  {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFDBDBDB),width: 1)
      ),
      child: DropdownButton<String>(
        underline: Container(),
        isExpanded: true,
        hint: CustomText(text:"ravi kumar" ),
        onChanged: (val){
          setState(() {
            // dropValue=val.toString();
          });
        },
        //value: dropValue,
        items: dropItem.map((e){
          return DropdownMenuItem<String>(value: e,child: CustomText(text:e.toString()),);
        }).toList(),
      ),
    );
  }


  var httpServices = HttpClientServices();

  void startDialysisApiCall() async {
    var prefs = await SharedPreferences.getInstance();
    var res = await httpServices.startDialysisApi(
        appointment_id: prefs.get('appointment_id').toString(),
        injectible_select: '',
        );
    if (res!.result == true) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>RemarksScreen()));
      });
    }
  }
}
