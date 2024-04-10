import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:get/get.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:health_care/screen/dialysis_centre/dialysis_centre_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_images.dart';
import '../../common/app_strings.dart';
import '../doctor_list_screen/doctor_list_screen.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  CarouselController buttonCarouselController = CarouselController();
  List<String> data = [
    "hkhdhfkd",
    "hdjkhskdksk",
  ];

  var dotIndex = 0;

  indexVal(int index, CarouselPageChangedReason a) {
    dotIndex = index;
    return dotIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Book Appointment',
      ),
      body: Column(
        children: [
          DesignConfig.space(h: 3.h),
          bannerCarousel(),
          DesignConfig.space(h: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: data.asMap().entries.map((e) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      buttonCarouselController.animateToPage(
                        e.key,
                      );
                    });
                  },
                  child: Container(
                    width: dotIndex == e.key ? 20 : 5,
                    height: dotIndex == e.key ? 5 : 5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        //shape: BoxShape.circle,
                        color: AppColors.primaryColor
                            .withOpacity(dotIndex == e.key ? 0.9 : 0.6)),
                  ));
            }).toList(),
          ),
          DesignConfig.space(h: 3.h),
          Center(
            child: CustomText(
              text: 'Select What you want for\nyour Appointment',
              fontWeight: FontWeight.w500,
              fontSize: 17.px,
              color: AppColors.blackColor,
              align: TextAlign.center,
            ),
          ),
          DesignConfig.space(h: 3.h),
          appointType(),
          DesignConfig.space(h: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: CustomUi.primaryButton('select', () {}, 11,
                AppColors.primaryColor, AppColors.whiteColor, 14, false),
          )
        ],
      ),
    );
  }

  Widget bannerCarousel() {
    return CarouselSlider.builder(
      itemCount: data.length,
      options: CarouselOptions(
        onPageChanged: (index, _) {
          setState(() {
            indexVal(index, _);
          });
        },
        height: 150,
        autoPlay: true,
        pauseAutoPlayOnTouch: true,
        pauseAutoPlayInFiniteScroll: true,
      ),
      itemBuilder: (ctx, index, i) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 1,
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey)
                ],
                borderRadius: BorderRadius.circular(15),),
            margin: const EdgeInsets.only(right: 10, bottom: 4, top: 5),
            //child: Image.network(homeData.value.banners![index].bannerImage!)
          ),
        );
      },
    );
  }

  Widget appointType() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: InkWell(
            onTap: (){
              Get.to(DoctorListScreen());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 20.h,
                  width: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: AssetImage(AppImages.dialysisIcon),
                          fit: BoxFit.cover)),
                ),
                DesignConfig.space(h: 1.h),
                CustomText(
                  text: 'Consult With a\nDoctor',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.blackColor,
                  align: TextAlign.center,
                )
              ],
            ),
          ),
        )),
        DesignConfig.space(w: 1.w),
        Expanded(
            child: InkWell(
              onTap: (){
                Get.to(DialysisCentreScreen());
              },
              child: Column(
          children: [
              Container(
                height: 20.h,
                width: 120,
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        image: AssetImage(AppImages.patientIcon),
                        fit: BoxFit.cover)),
              ),
              DesignConfig.space(h: 1.h),
              CustomText(
                text: 'Dialysis Centre',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.blackColor,
              )
          ],
        ),
            ))
      ],
    );
  }
}
