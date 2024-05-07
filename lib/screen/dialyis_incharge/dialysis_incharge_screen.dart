import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/http_client_request.dart';
import 'package:health_care/common/save_start_dialysis_data.dart';
import 'package:health_care/screen/dialyis_incharge/select_machine_diaysis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/app_colors.dart';
import '../../models/client_dialysis_appointment/client_dialysis_appointment_model.dart';


class DialysisIncharge extends StatefulWidget {
  const DialysisIncharge({super.key});

  @override
  State<DialysisIncharge> createState() => _DialysisInchargeState();
}

class _DialysisInchargeState extends State<DialysisIncharge> {


  @override
  void initState() {
    // TODO: implement initState
    clientAppointment();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:InkWell(
        onTap: (){
          if(appointmentsSelect==null){
            Fluttertoast.showToast(msg: 'Please select type...');
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
      appBar: DesignConfig.appBar(context, double.infinity, 'Consultant Incharge'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SvgPicture.asset('assets/svg/consultIncharge.svg',alignment: Alignment.center,)),
              DesignConfig.space(h: 30),
              CustomText(text: 'Please select',color: const Color(0xFFA1A1A1),fontWeight: FontWeight.w400,fontSize: 13,),
              DesignConfig.space(h: 10),
              consultantDrop()
            ],
          ),
        ),
      ),
    );
  }

List<String> dropItem=["Ravi Kumar","hi","hello"];
  String dropValue="Ravi kumar";

  Widget consultantDrop()
  {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFFDBDBDB),width: 1)
      ),
      child: DropdownButton<Appointments>(
        underline: Container(),
        isExpanded: true,

        onChanged: (Appointments? val){
          setState(() {
            appointmentsSelect=val;
          });
        },
       //value: appointmentsSelect,
        hint: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(text: appointmentsSelect==null?"Please Select":appointmentsSelect!.userName.toString()),
        ),
        items: appointments.map((e){
          return DropdownMenuItem<Appointments>(value: e,child: CustomText(text:e.userName.toString()),);
        }).toList(),
      ),
    );
  }
  List<Appointments> appointments = [];
  Appointments? appointmentsSelect;
final HttpClientServices httpClientServices=HttpClientServices();
  void clientAppointment() async {
    var res = await httpClientServices.clientAppointmentApi(status: 'queue');
    if (res!.result == true) {
      setState(() {
        appointments = res.appointments!;
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }


  void startDialysisApiCall()async{
    var res=await httpClientServices.startDialysisApi(appointment_id: appointmentsSelect!.id.toString());
    var prefs=await SharedPreferences.getInstance();
    if(res!.result==true)
      {
        setState(() {
          prefs.setString('appointment_id', appointmentsSelect!.id.toString());
          Navigator.push(context, MaterialPageRoute(builder: (_)=>SelectMachineScreen()));
        });
      }
  }



}
