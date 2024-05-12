import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_client_request.dart';
import '../../models/start_dialysis_model/start_dialysis_model.dart';
import 'heamodialysis_orders_screen.dart';


class BpPlusSpoScreen extends StatefulWidget {
  StartDialysisAppointment appointment;
   BpPlusSpoScreen({super.key,required this.appointment});

  @override
  State<BpPlusSpoScreen> createState() => _BpPlusSpoScreenState();
}

class _BpPlusSpoScreenState extends State<BpPlusSpoScreen> {
  final TextEditingController bloodController=TextEditingController();
  final TextEditingController pluseController=TextEditingController();
  final TextEditingController spo2Controller=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    Fluttertoast.showToast(msg: widget.appointment.bp.toString());
    if(widget.appointment.bp!=null)
    {
      bloodController.text=widget.appointment.bp.toString();
    }
    if(widget.appointment.pulse!=null)
      {
        pluseController.text=widget.appointment.pulse.toString();
      }
    if(widget.appointment.spo2!=null)
      {
        spo2Controller.text=widget.appointment.spo2.toString();
      }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'B.P, Pulse, Spo2(Pre)'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesignConfig.space(h: 10),
              CustomText(text: 'Blood Pressure'),
              CustomUi.editBox('Enter here', bloodController, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Pulse'),
              CustomUi.editBox('Enter here', pluseController, TextInputType.text,),
              DesignConfig.space(h: 10),
              CustomText(text: 'Spo2'),
              CustomUi.editBox('Enter here', spo2Controller, TextInputType.text,),
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
     bp: bloodController.text.toString(),
      pulse: pluseController.text.toString(),
      spo2: spo2Controller.text.toString()
    );
    if (res!.result == true) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>HeamodialysisOrdersScreen(appointment: res.appointment!,)));

      });
    }
  }


}
