import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/custom_ui.dart';
import '../../common/http_request.dart';

class BookAppointmnetSummaryScreen extends StatefulWidget {
  final image,name,id,date,bio,selectSlots,type;
   BookAppointmnetSummaryScreen({super.key,this.image,this.name,this.id,this.bio,this.selectSlots, this.date,this.type});

  @override
  State<BookAppointmnetSummaryScreen> createState() => _BookAppointmnetSummaryScreenState();
}

class _BookAppointmnetSummaryScreenState extends State<BookAppointmnetSummaryScreen> {
  final HttpServices httpServices = HttpServices();
  void boolAppointmentApi()async{
    var res=await httpServices.boolAppointmentApi(type: widget.type,date: widget.date.toString(),hospitalId: widget.id,slots: widget.selectSlots);
    if(res!.result==true)
    {
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Finalise your appointment',
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: CustomUi.primaryButton('Confirm and pay', () {
          if(widget.selectSlots=='')
          {
            Fluttertoast.showToast(msg: "please select slots..");
          }
          else
          {
            boolAppointmentApi();
          }

        }, 11,
            AppColors.primaryColor, AppColors.whiteColor, 14, false),
      ),
      body: Column(
        children: [
          hospitalDetails(),
          DesignConfig.space(h: 1.h),
          appointmentSlotsWidget(),
        ],
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
                        image: DecorationImage(
                            image: NetworkImage(widget.image.toString()))),
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
                            text: widget.name.toString(),
                            color: const Color(0xFF3C3C3C),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          const Icon(Icons.heart_broken),
                        ],
                      ),
                      CustomText(
                        text: widget.bio.toString(),
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
                  CustomText(
                    text: '4.0',
                    color: const Color(0xFF3C3C3C),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  DesignConfig.space(w: 1.w),
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.star,
                      color: AppColors.yellowColor,
                      size: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 5.h,
                alignment: Alignment.bottomRight,
                width: MediaQuery.of(context).size.width / 1.4,
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

  Widget appointmentSlotsWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.5),
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(text: 'Appointment time :'),
              CustomText(text: widget.selectSlots.toString())

            ],
          ),
          DesignConfig.space(h: 1.5.h),
          Row(
            children: [
              CustomText(text: 'Service Type :'),
              CustomText(text: widget.type.toString())

            ],
          ),
          DesignConfig.space(h: 1.5.h),
          Row(
            children: [
              CustomText(text: 'Doctor :'),
              CustomText(text: widget.name.toString())

            ],
          ),
          DesignConfig.space(h: 1.5.h),
          CustomText(text: 'Visit',linethrough: TextDecoration.underline,fontWeight: FontWeight.w400,fontSize: 12,),
          DesignConfig.space(h: 1.5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
             Icon(Icons.location_on,size: 16,color: Color(0xFF939393),),
              Expanded(child: CustomText(text: '150, Bharath Nagar Road Jeewan Nagar, Gate Number 1, Maharani Bagh, New Delhi, Delhi 110014',fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xFF939393),))

            ],
          ),
        ],
      ),
    );
  }


}
