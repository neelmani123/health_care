import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:health_care/common/http_request.dart';
import 'package:health_care/screen/dialysis_centre/book_hospital_appointment.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../models/dialysis_centre_model/dialysis_centre_model.dart';

class DialysisCentreScreen extends StatefulWidget {
  const DialysisCentreScreen({super.key});

  @override
  State<DialysisCentreScreen> createState() => _DialysisCentreScreenState();
}

class _DialysisCentreScreenState extends State<DialysisCentreScreen> {
  final HttpServices httpServices=HttpServices();
  bool loading=true;
  List<DialysisCenter> dialysisCenter=[];
  
  void dialysisCentreApi()async{
    
    final res=await httpServices.dialysisCentreApi();
    if(res!.result==true)
      {
        setState(() {
          dialysisCenter=res.dialysisCenter!;
          loading=false;
        });
      }
    else
      {
        Fluttertoast.showToast(msg: res.message);
      }
    
  }
  
  @override
  void initState() {
    // TODO: implement initState
    dialysisCentreApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 15.w),
      //   child: CustomUi.primaryButton('select', () {
      //
      //   }, 11,
      //       AppColors.primaryColor, AppColors.whiteColor, 14, false),
      // ),
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Dialysis Centre',
      ),
      body: (loading)?Center(child: CircularProgressIndicator(),):dialysisCenter.isEmpty?Center(child: CustomText(text: "No data found..."),):Column(
        children: [
          DesignConfig.space(h: 2.h),
          Expanded(child: dialysisCentrreData()),
        ],
      ),
    );
  }

  Widget dialysisCentrreData() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: dialysisCenter.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to( BookHospitalAppointment(hospitalId: dialysisCenter[index].id.toString(),));
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
                      child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                       image: DecorationImage(image: NetworkImage(dialysisCenter[index].image.toString()))),
                  )),
                  DesignConfig.space(w: 5.w),
                  Expanded(
                    flex: 4,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(text: dialysisCenter[index].name.toString(),color: const Color(0xFF3C3C3C),fontSize: 15,fontWeight: FontWeight.w400,),
                      DesignConfig.space(h: 1.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on,color: AppColors.primaryColor,size: 16,),
                          CustomText(text: dialysisCenter[index].address.toString(),color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,),
                        ],
                      ),
                      DesignConfig.space(h: 0.5.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DesignConfig.space(w: 1.w),
                          CustomText(text: dialysisCenter[index].totalRatings.toString(),color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,),
                          DesignConfig.space(w: 1.w),
                        const  Padding(
                            padding:  EdgeInsets.only(top: 2),
                            child:  Icon(Icons.star,color: AppColors.yellowColor,size: 12,),
                          ),

                        ],
                      ),
                    ],
                  )),
                  const Expanded(child: Padding(
                    padding:  EdgeInsets.only(top: 25),
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios,color: Color(0xFF666666),size: 14,),
                    ),
                  ))
                ],
              ),
            ),
          );
        });
  }
}
