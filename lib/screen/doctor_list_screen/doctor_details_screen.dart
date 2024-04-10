import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_request.dart';
import '../../models/doctor_list_model/doctor_details_model.dart';
import 'book_dialysis_slots_screen.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final id;
  const DoctorDetailsScreen({super.key,this.id});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  final HttpServices httpServices=HttpServices();
  bool loading=true;
  Doctors doctors=Doctors();

  void doctorDetailsApi()async{

    final res=await httpServices.doctorDetailsApi(hospitalId: widget.id.toString());
    if(res!.result==true)
    {
      setState(() {
        doctors=res.doctors!;
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
    doctorDetailsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: CustomUi.primaryButton('Book Now', () {
          Get.to(BookDialysisslotsScreen(type: 'hospital',id: widget.id.toString(),image: doctors.image.toString(),bio: doctors.bio.toString(),name: doctors.name.toString(),));
        }, 11,
            AppColors.primaryColor, AppColors.whiteColor, 14, false),
      ),
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Book Hospital Appointment',
      ),
      body: SingleChildScrollView(
        child: (loading)?const Center(child: CircularProgressIndicator(),):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            hospitalDetails(),
            DesignConfig.space(h: 2.h),
            serviceTime(),
            DesignConfig.space(h: 2.h),
            servicesWidget(),
            DesignConfig.space(h: 2.h),
            const Divider(
              color: Color(0xFF6772941A),
              thickness: 0.8,
            ),
            DesignConfig.space(h: 2.h),
            locationWidget(),
            DesignConfig.space(h: 2.h),
            const Divider(
              color: Color(0xFF6772941A),
              thickness: 0.8,
            ),

          ],
        ),
      ),
    );
  }

  Widget hospitalDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(17.px), boxShadow: [
        BoxShadow(
            color: AppColors.blackColor.withOpacity(0.5),
            blurRadius: 1,
            blurStyle: BlurStyle.outer)
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
                  flex: 2,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(doctors.image.toString()))),
                  )),
              DesignConfig.space(w: 5.w),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: doctors.name.toString(),
                            color: const Color(0xFF3C3C3C),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          const Icon(Icons.heart_broken),
                        ],
                      ),
                      CustomText(
                        text:
                        doctors.bio.toString(),
                        color: const Color(0xFF677294),
                        fontSize: 9,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  )),
            ],
          ),
          DesignConfig.space(h: 1.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text:  '4.0',color: const Color(0xFF3C3C3C),fontSize: 10,fontWeight: FontWeight.w400,),
                  DesignConfig.space(w: 1.w),
                  const  Padding(
                    padding:  EdgeInsets.only(top: 2),
                    child:  Icon(Icons.star,color: AppColors.yellowColor,size: 12,),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 5.h,
                alignment: Alignment.bottomRight,
                width: MediaQuery.of(context).size.width/1.4,
                padding: EdgeInsets.only(left: 20.w),
                child: CustomUi.primaryButton('Contact', () {}, 11,
                    AppColors.primaryColor, AppColors.whiteColor, 14, false),
              ),

            ],
          )
        ],
      ),
    );
  }

  Widget serviceTime(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(17.px), boxShadow: [
        BoxShadow(
            color: AppColors.blackColor.withOpacity(0.5),
            blurRadius: 1,
            blurStyle: BlurStyle.outer)
      ]),
      child: Row(
        children: [
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
            BoxDecoration(
                color: Color(0xFFCBCBCB).withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.px), boxShadow: [
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: '24/7',color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: 16,),
                CustomText(text: 'Service',color: Color(0xFF677294),fontWeight: FontWeight.w300,fontSize: 12,),

              ],
            ),

          )),
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
            BoxDecoration(
                color: Color(0xFFCBCBCB).withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.px), boxShadow: [
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'Cancer',color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: 16,),
                CustomText(text: 'Surgery',color: Color(0xFF677294),fontWeight: FontWeight.w300,fontSize: 12,),

              ],
            ),

          )),
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration:
            BoxDecoration(
                color: Color(0xFFCBCBCB).withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.px), boxShadow: [
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: '24 hour',color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: 16,),
                CustomText(text: 'Emergency',color: Color(0xFF677294),fontWeight: FontWeight.w300,fontSize: 12,),

              ],
            ),

          )),
        ],
      ),
    );
  }

  Widget servicesWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'Services',fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF333333),),
          DesignConfig.space(h: 2.h),
          Row(
            children: [
              CustomText(text: '1.',color: AppColors.primaryColor,fontWeight: FontWeight.w300,fontSize: 12,),
              CustomText(text: 'Patient care should be the number one priority.',color: Color(0xFF677294),fontWeight: FontWeight.w400,fontSize: 12,),
            ],
          ),
          DesignConfig.space(h: 1.h),
          const Divider(
            color: Color(0xFF6772941A),
            thickness: 0.8,
          ),
          DesignConfig.space(h: 1.h),
          Row(
            children: [
              CustomText(text: '2.',color: AppColors.primaryColor,fontWeight: FontWeight.w300,fontSize: 12,),
              CustomText(text: 'If you run your practiceyou know how frustrating.',color: Color(0xFF677294),fontWeight: FontWeight.w400,fontSize: 12,),
            ],
          ),
          DesignConfig.space(h: 1.h),
          const Divider(
            color: Color(0xFF6772941A),
            thickness: 0.8,
          ),
          DesignConfig.space(h: 1.h),
          Row(
            children: [
              CustomText(text: '3.',color: AppColors.primaryColor,fontWeight: FontWeight.w300,fontSize: 12,),
              CustomText(text: 'That’s why some of appointment reminder system.',color: Color(0xFF677294),fontWeight: FontWeight.w400,fontSize: 12,),
            ],
          ),

        ],
      ),
    );
  }
  Widget locationWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'Location',fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF333333),),
          DesignConfig.space(h: 2.h),
          Container(
            height: 100,
            //padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // margin: const EdgeInsets.symmetric( vertical: 10),
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(17.px), boxShadow: [
              BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.5),
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer)
            ]),

          )
        ],
      ),
    );
  }
}
