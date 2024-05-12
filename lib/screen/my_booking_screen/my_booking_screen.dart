import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/http_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/http_client_request.dart';
import '../../common/pref_manager.dart';
import '../../models/doctor_list_model/my_booking_model.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> with TickerProviderStateMixin{
  late TabController tabController;
  List<Appointments> appointments=[];
  final HttpServices httpServices=HttpServices();
  var loginType;
  final HttpClientServices httpClientServices = HttpClientServices();
  int page=1;
  var type='pending';
  ScrollController? _scrollController;

  _scrollListener() {
    if (_scrollController!.offset >=
        _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      page += 1;
      print("Pages is$page");
      myAppointmentApi();

    }
  }

  void myAppointmentApi()async {

    var res;
    if(loginType=="client"){
      //res = await httpClientServices.myAppointmentApi(status: type);
    }
    else{
      res = await httpServices.myAppointmentApi(status: type,page: page);
    }
    if (res!.result == true)
  {
    setState(() {
      appointments.addAll(res.appointments!);
    });
  }
    else
      {
        Fluttertoast.showToast(msg: res.message.toString());
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
    tabController = TabController(length: 2, vsync: this);
    PrefManager.getLoginUserTypeValue().then((value){
      setState(() {
        loginType=value;
      });
    });
    myAppointmentApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'My Booking',
      ),
      body: Column(
        children: [
          TabBar(
              onTap: (val){
                if(val==0)
                {
                  setState(() {
                    appointments.clear();
                    page=1;
                    type='pending';
                    myAppointmentApi();
                  });


                }
                else if(val==1)
                {
                  setState(() {
                    type='completed';
                    appointments.clear();
                    page=1;
                    myAppointmentApi();
                  });

                }
              },
              isScrollable: false,
              controller: tabController, tabs: const [
            Tab(
              text: 'Schedule',
            ),
            Tab(
              text: 'Completed',
            ),
          ]),
          Expanded(child: dialysisCentrreData())
        ],
      ),
    ));
  }

  Widget dialysisCentrreData() {
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              //Get.to( BookHospitalAppointment(hospitalId: dialysisCenter[index].id.toString(),));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.px),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.blackColor.withOpacity(0.5),
                        blurRadius: 1,
                        blurStyle: BlurStyle.outer)
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: appointments[index].image==""?Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: AssetImage('assets/images/profile.png'))),
                      ):Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(image: NetworkImage(appointments[index].image.toString()))),
                      )),
                  DesignConfig.space(w: 5.w),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(text: appointments[index].hospitalName.toString(),color: const Color(0xFF3C3C3C),fontSize: 15,fontWeight: FontWeight.w400,),
                          DesignConfig.space(h: 1.h),
                         Container(
                           width: 105,
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.primaryColor)
                           ),
                           child: Row(
                             children: [
                              SvgPicture.asset('assets/svg/document.svg',height: 16,),
                               DesignConfig.space(w: 2.w),
                               CustomText(text: 'Prescription',fontWeight: FontWeight.w400,color: Color(0xFF7A7A7A),fontSize: 10,)
                             ],
                           ),
                         ),
                          DesignConfig.space(h: 1.h),
                          Row(
                            children: [
                              SvgPicture.asset('assets/svg/lastdial.svg',height: 16,),
                              DesignConfig.space(w: 2.w),
                              CustomText(text: 'Last Dialysis (${appointments[index].lastDialysis.toString()})',fontWeight: FontWeight.w400,color: Color(0xFF7A7A7A),fontSize: 10,)
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}
