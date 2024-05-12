import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/http_client_request.dart';
import '../../models/client_dialysis_appointment/client_dialysis_appointment_model.dart';
import 'dialysis_incharge_screen.dart';


class StartDialysisFirstScreen extends StatefulWidget {
  const StartDialysisFirstScreen({super.key});

  @override
  State<StartDialysisFirstScreen> createState() => _StartDialysisFirstScreenState();
}

class _StartDialysisFirstScreenState extends State<StartDialysisFirstScreen> {
  List<Appointments> appointments = [];
  final HttpClientServices httpClientServices = HttpClientServices();
  void clientAppointment(String type) async {
    var res = await httpClientServices.clientAppointmentApi(status: type);

    if (res!.result == true) {
      setState(() {
        appointments = res.appointments!;
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }


  @override
  void initState() {
    // TODO: implement initState

    clientAppointment('schedule');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Start Dialysis'),
      body: dialysisDataWidget(),
    );
  }



  Widget dialysisDataWidget() {
    return appointments.isEmpty
        ? Center(
      child: CustomText(text: 'No data found..'),
    )
        : ListView.builder(
        itemCount: appointments.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.17),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 2)
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 80,
                              margin: EdgeInsets.only(bottom: 7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        appointments[index].image.toString(),
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  height: 25,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(bottom: 0),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Color(0xFFA5A5A5), width: 2)),
                                  child: Text(
                                    appointments[index].slotTime.toString(),
                                    style: TextStyle(
                                        fontSize: 8,
                                        color: AppColors.whiteColor),
                                    textAlign: TextAlign.center,
                                  )),
                            )
                          ],
                        )),
                    DesignConfig.space(w: 10),
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: appointments[index].userName.toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackColor,
                            ),
                            DesignConfig.space(h: 10),
                            Container(
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: AppColors.primaryColor
                                          .withOpacity(0.5),
                                      width: 1)),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/document.svg',
                                    height: 16,
                                  ),
                                  DesignConfig.space(w: 2.w),
                                  CustomText(
                                    text: 'Prescription',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF7A7A7A),
                                    fontSize: 10,
                                  )
                                ],
                              ),
                            ),
                            DesignConfig.space(h: 10),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/lastdial.svg',
                                  height: 16,
                                ),
                                DesignConfig.space(w: 2.w),
                                CustomText(
                                  text:
                                  'Last Dialysis(${appointments[index].lastDialysisDate.toString()})',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 10,
                                )
                              ],
                            ),
                            DesignConfig.space(h: 10),
                           Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: ()async{
                                    var prefs=await SharedPreferences.getInstance();
                                    setState(() {
                                      prefs.setString('appointment_id', appointments[index].id.toString());
                                      Fluttertoast.showToast(msg: appointments[index].id.toString());
                                      Get.to(DialysisIncharge(id: appointments[index].id,));
                                    });
                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width / 3.5,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: Color(0xFF55FF52), width: 1)),
                                    child: CustomText(
                                      text: 'Start',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF55FF52),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ))
                  ],
                ),

              ],
            ),
          );
        });
  }
}
