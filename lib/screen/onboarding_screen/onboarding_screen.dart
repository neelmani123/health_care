import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_care/common/app_images.dart';
import 'package:health_care/common/app_strings.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:health_care/screen/authentication_screen/login_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../authentication_screen/identity_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int dotIndex = 0;

  indexVal(int index, CarouselPageChangedReason a) {
    dotIndex = index;
    return dotIndex;
  }

  List<String> slideImage = [AppImages.onboard1Icon, AppImages.onboard1Icon1,AppImages.onboard1Icon2];
  List<String> slidetitle = [
    'Now it’s easy to order your medicine',
    'Don’t waste your time.',
    'Don’t waste your time.'
  ];
  List<String> slidetext = [
    AppStrings.onboard1String1,
    AppStrings.onboard1String2,
    AppStrings.onboard1String3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            decoration: const BoxDecoration(color: AppColors.whiteColor),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height / 12,
                  ),
                  _buildCarousel(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: slideImage.asMap().entries.map((e) {
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
                        ),
                      );
                    }).toList(),
                  ),
                  const Spacer(),
                  CustomUi.primaryButton('Next', (){
                    Get.to(IdentityScreen());
                  }, 10, AppColors.primaryColor, AppColors.whiteColor, 17.px, false)
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: Get.height * 0.80,
      child: CarouselSlider.builder(
        options: CarouselOptions(
            enlargeCenterPage: true,
            height: Get.height * 0.7,
            autoPlay: true,
            reverse: false,
            enableInfiniteScroll: true,
            initialPage: 0,
            aspectRatio: 0.85,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayInFiniteScroll: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, _) {
             setState(() {
               indexVal(index, _);
             });
            }),
        itemCount: slideImage.length,
        carouselController: buttonCarouselController,
        itemBuilder: (ctx, index, i) {
          return Container(
              // margin: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              // height: Get.height,
              //height: 200,
              // width: Get.width * 0.7,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: slidetitle[index],
                    fontSize: 14.px,
                    fontFamily: 'poppins',
                    align: TextAlign.start,
                    color: AppColors.onboard,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    text: slidetext[index],
                    fontSize: 24.px,
                    fontFamily: 'poppins',
                    align: TextAlign.start,
                    color: Color(0xFF504D4D),
                    fontWeight: FontWeight.w600,
                  ),
                  Hero(
                    tag: "image1",
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(6)),
                        height: Get.height / 2.4,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Image.asset(slideImage[index])
                        // SvgPicture.asset(
                        //   controller.bannerOffer[index],
                        // )
                        ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                ],
              ));
        },
      ),
    );
  }
}
