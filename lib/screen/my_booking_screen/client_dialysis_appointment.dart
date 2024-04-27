
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/http_client_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../models/client_dialysis_appointment/client_dialysis_appointment_model.dart';
import '../../models/doctor_list_model/slots_model.dart';
import 'client_dialysis_appointment_details_screen.dart';

class ClientDialysisAppointment extends StatefulWidget {
  const ClientDialysisAppointment({super.key});

  @override
  State<ClientDialysisAppointment> createState() =>
      _ClientDialysisAppointmentState();
}

class _ClientDialysisAppointmentState extends State<ClientDialysisAppointment>
    with TickerProviderStateMixin {
  late TabController tabController;

  final HttpClientServices httpClientServices = HttpClientServices();
  List<Appointments> appointments = [];
  var type = 'queue';
  List<Slots> slots=[];
  var select  ;
  var selectSlots;

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

  void updateAppointment(
      String aapointmentID, String slotTime, String date, String status) async {
    var res = await httpClientServices.clientUpdateAppointmentApi(
        status: status,
        date: date,
        appointment_id: aapointmentID,
        slot_time: slotTime);
    if (res!.result == true) {
      setState(() {
        clientAppointment(type);
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }
  void getSlotsApi() async {
    var res = await httpClientServices.slotsApi(date: '',type: '',hospitalId: '');
    if (res!.result == true) {
      setState(() {
        slots=res.slots!;
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    clientAppointment(type);
    getSlotsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: DesignConfig.appBar(
            context, double.infinity, 'Dialysis Appointment'),
        body: Column(
          children: [
            DesignConfig.space(h: 2.h),
            searchWidget(),
            DesignConfig.space(h: 10),
            TabBar(
                onTap: (val) {
                  if (val == 0) {
                    setState(() {
                      type = 'queue';
                      clientAppointment('queue');
                    });
                  } else if (val == 1) {
                    setState(() {
                      type = 'schedule';
                      clientAppointment('schedule');
                    });
                  } else if (val == 2) {
                    setState(() {
                      type = 'completed';
                      clientAppointment('completed');
                    });
                  }
                },
                isScrollable: false,
                controller: tabController,
                tabs: const [
                  Tab(
                    text: 'Queue',
                  ),
                  Tab(
                    text: 'Schedule',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                ]),
            Expanded(child: dialysisDataWidget())
          ],
        ),
      ),
    );
  }

  Widget searchWidget() {
    return Container(
        height: 5.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F2E9),
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(
                Icons.filter_alt_outlined,
                size: 18,
                color: Color(0xFF878B91),
              ),
              border: InputBorder.none,
              hintText: 'Search Medicine & Health Concern',
              hintStyle: TextStyle(
                  color: Color(0xFF818286),
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
        ));
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
                                type=="schedule"||type=="completed"?Container():appointments[index].isExpanded==true?Container():Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          appointments[index].isExpanded=true;
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
                                          text: 'Accept',
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF55FF52),
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        updateAppointment(
                                            appointments[index].id.toString(),
                                            '',
                                            '',
                                            '3');
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width / 3.5,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(
                                                color: Color(0xFFFF5050),
                                                width: 1)),
                                        child: CustomText(
                                          text: 'Decline',
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFFF5050),
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
                    appointments[index].isExpanded==true?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Center(child: CustomText(text: 'Select Time Slot',fontWeight: FontWeight.w400,fontSize: 12,linethrough: TextDecoration.underline,)),
                        SizedBox(height: 10,),
                        Center(child: CustomText(text: 'Preferred Time',fontWeight: FontWeight.w200,fontSize: 8,)),
                        SizedBox(height: 5,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 35,
                          child: ListView.builder(
                              itemCount: slots.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index1) {
                                if(appointments[index].slotTime==(slots[index1].startTime.toString() + "-"+slots[index1].endTime.toString()))
                                  {
                                    select=index1;
                                  }
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      select = index1;
                                      selectSlots =
                                      "${slots[index1].startTime.toString() + "-" + slots[index1].endTime.toString()}";
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 5, right: 2),
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: AppColors.primaryColor.withOpacity(0.4), width: 1.5),
                                        borderRadius: BorderRadius.circular(20),
                                        color: select == index1
                                            ? AppColors.primaryColor.withOpacity(0.4)
                                            : AppColors.whiteColor),
                                    padding: const EdgeInsets.symmetric(horizontal: 7),
                                    child: Text("${slots[index1].startTime}-${slots[index1].endTime}",style: TextStyle(color: select == index1
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,fontSize: 10),)
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  Get.to(ClientDialysisAppointmentDetailsScreen(id: appointments[index].userId.toString(),slotTime: selectSlots.toString(),appointmentId: appointments[index].id.toString(),));
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
                                  text: 'Assign',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF55FF52),
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                               setState(() {
                                 appointments[index].isExpanded=false;
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
                                        color: Color(0xFFFF5050),
                                        width: 1)),
                                child: CustomText(
                                  text: 'Cancel',
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFF5050),
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        )

                      ],
                    ):SizedBox.shrink(),
                  ],
                ),
              );
            });
  }





}
