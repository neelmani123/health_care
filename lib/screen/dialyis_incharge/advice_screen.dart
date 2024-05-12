import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../../models/start_dialysis_model/start_dialysis_model.dart';
import 'injectable_screen.dart';

class AdviceScreen extends StatefulWidget {
  StartDialysisAppointment appointment;
   AdviceScreen({super.key,required this.appointment});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  final TextEditingController enter=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    if(widget.appointment!.advice==""||widget.appointment!.advice==null)
      {

      }
    else
      {
        enter.text=widget.appointment!.advice.toString();
      }
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Advice'),
      bottomSheet:InkWell(
        onTap: (){
          if(enter.text.isEmpty)
          {
            Fluttertoast.showToast(msg: 'Please enter advice...');
          }
          else
          {
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:   SvgPicture.asset('assets/svg/advice.svg'),
            ),
            DesignConfig.space(h: 40),
            CustomText(text: 'Advice'),
            DesignConfig.space(h: 20),
            Container(
              height: 100,
                child: CustomUi.editBox('Enter here', enter, TextInputType.text,))
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
        advice: enter.text.toString(),
        blood_tubing_set_text: enter.text.toString());
    if (res!.result == true) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>InjectableScreen(appointment: res.appointment!,)));
      });
    }
  }
}
