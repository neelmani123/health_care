import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/screen/doctor_list_screen/doctor_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/http_request.dart';
import '../../models/doctor_list_model/doctor_list_model.dart';


class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final HttpServices httpServices=HttpServices();
  bool loading=true;
  List<DoctorsList> doctorsList=[];

  void dialysisCentreApi()async{

    final res=await httpServices.doctorListApi();
    if(res!.result==true)
    {
      setState(() {
        doctorsList=res.doctorsList!;
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
        'Book Appointment',
      ),
      body: (loading)?Center(child: CircularProgressIndicator(),):doctorsList.isEmpty?Center(child: CustomText(text: "No data found..."),):Column(
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
        itemCount: doctorsList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to( DoctorDetailsScreen(id: doctorsList[index].id.toString(),));
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
                            image: DecorationImage(image: NetworkImage(doctorsList[index].image.toString()),fit: BoxFit.cover)),
                      )),
                  DesignConfig.space(w: 5.w),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         Row(
                           children: [
                             Expanded(child: CustomText(text: doctorsList[index].name.toString(),color: const Color(0xFF3C3C3C),fontSize: 15,fontWeight: FontWeight.w400,)),
                             Container(
                               decoration: BoxDecoration(
                                 color: AppColors.primaryColor,
                                 borderRadius: BorderRadius.circular(10)
                               ),
                               padding: EdgeInsets.all(5),
                               child: CustomText(text:doctorsList[index].experience.toString()+"Yrs Exp",fontWeight: FontWeight.w300,fontSize: 10, color: AppColors.whiteColor,),
                             )
                           ],
                         ),
                          DesignConfig.space(h: 1.h),
                          CustomText(text: doctorsList[index].degree.toString(),color: const Color(0xFF677294),fontSize: 10,fontWeight: FontWeight.w300,),
                          DesignConfig.space(h: 1.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(text: "4.0",color: AppColors.blackColor,fontSize: 11,fontWeight: FontWeight.w500,),
                              const Icon(Icons.star_rate,color: AppColors.yellowColor,size: 16,),
                              Spacer(),
                              CustomText(text: "₹"+doctorsList[index].fees.toString(),color: const Color(0xFF5E5E5E),fontSize: 11,fontWeight: FontWeight.w500,),

                            ],
                          ),
                          DesignConfig.space(h: 0.5.h),

                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}
