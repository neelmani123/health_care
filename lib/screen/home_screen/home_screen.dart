import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/app_images.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:health_care/common/http_request.dart';
import 'package:health_care/common/pref_manager.dart';
import 'package:health_care/screen/blogs_screen/blogs_screen.dart';
import 'package:health_care/screen/dialysis_centre/dialysis_centre_screen.dart';
import 'package:health_care/screen/home_screen/book_appointment_screen.dart';
import 'package:health_care/screen/home_screen/qr_scanner_screen.dart';
import 'package:health_care/screen/upload_records/prescription_details.dart';
import 'package:health_care/screen/upload_records/upload_records_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/http_client_request.dart';
import '../../models/home_model/home_model.dart';
import '../dialyis_incharge/dialysis_incharge_screen.dart';
import '../dialysis_product/dialysis_product_screen.dart';
import '../my_booking_screen/client_dialysis_appointment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpServices httpServices = HttpServices();
  bool loading = true;

  List<String> dailySisIcon = [
    AppImages.qrCodeIcon,
    AppImages.dialysisAppointmentIcon,
    AppImages.dialysisCentre,
    AppImages.buyDialysisProductIcon,
    AppImages.dialysisRecord,
    AppImages.uploadRecordIcon
  ];
  List<Color> color = [
    const Color(0xFFACDDF1),
    const Color(0xFFFDB3B6),
    const Color(0xFFA9B0EC),
    const Color(0xFFC5D7F3),
    const Color(0xFFE5C5A7),
    const Color(0xFFFFA9A9),
  ];
  List<String> dialysisTitle = [
    'Qr Code Scanner',
    'Book Dialysis\nAppointment',
    'Dialysis Centre Near me',
    'Buy Dailysis Product',
    'Dialysis Record',
    'Upload Report'
  ];

  List<String> clientDialysisTitle = [
    'Qr Code Scanner',
    'Dialysis Appointments',
    'Patient Medical Records',
    'Buy Dialysis Product',
    'Upload Prescription',
    'Upload Report'
  ];
  List<Color> schoolAcademicColor = [
    const Color(0xFFFFBFDA),
    const Color(0xFFFFAFAC),
    const Color(0xFFACD6FF),
    const Color(0xFFD19FD2),
    const Color(0xFFB5A5FE),
    const Color(0xFFBBFFCF),
  ];
  HomeData? homeData;
  final HttpClientServices httpClientServices = HttpClientServices();
  var loginType;

  Future homeApi() async {
    var prefs = await SharedPreferences.getInstance();
    var res;
    if (prefs.get('login_type').toString() == "client") {
      res = await httpClientServices.homeApi();
    } else {
      res = await httpServices.homeApi();
    }

    if (res!.result == true) {
      setState(() {
        homeData = res.homeData!;
        profileApi();
        loading = false;
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }

  void profileApi() async {
    var prefs = await SharedPreferences.getInstance();
    var res;
    if (prefs.get('login_type').toString() == "client") {
      res = await httpClientServices.profileApi();
      if (res!.result == true) {
        setState(() {
          PrefManager.clientProfileDataSave(res);
        });
      } else {
        Fluttertoast.showToast(msg: res.message.toString());
      }
    } else {
      res = await httpServices.profileApi();
      if (res!.result == true) {
        setState(() {
          PrefManager.profileDataSave(res);
        });
      } else {
        Fluttertoast.showToast(msg: res.message.toString());
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    PrefManager.getLoginUserTypeValue().then((value){
      setState(() {
        loginType=value;
      });
    });
    homeApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      bottomSheet:InkWell(
        onTap: (){
          Get.to(DialysisIncharge());
        },
        child: Container(
          width: 150,
          height: 35,
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.primaryColor
          ),
          child: CustomText(text: 'Start Dialysis',color: AppColors.whiteColor,),
        ),
      ),
      body: (loading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: homeApi,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DesignConfig.space(h: 2.h),
                      searchWidget(),
                      DesignConfig.space(h: 2.h),
                      bannerWidget(),
                      DesignConfig.space(h: 3.h),
                      loginType=="client"?clientDialysisWidget():dialysisWidget(),
                      DesignConfig.space(h: 2.h),
                      bestSelling(),
                      DesignConfig.space(h: 2.h),
                      blogs(),
                      DesignConfig.space(h: 2.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget bannerWidget() {
    return Container(
      height: 15.h,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: homeData!.banners!.length,
          itemBuilder: (context, index) {
            return Container(
              height: 10.h,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: Get.width / 1.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          homeData!.banners![index].image.toString()),
                      fit: BoxFit.fill)),
            );
          }),
    );
  }

  Widget searchWidget() {
    return Container(
        height: 7.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F2E9),
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.search,
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

  Widget dialysisWidget() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
            mainAxisExtent: 140),
        itemCount: dailySisIcon.length,
        itemBuilder: (contex, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                // Get.to(PrescriptionDetailsScreen());
                Get.to(QrScreenScreen());
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BookAppointmentScreen()));
              } else if (index == 2) {
                Get.to(DialysisCentreScreen());
              } else if (index == 3) {
                Get.to(DialysisProductScreen());
              } else if (index == 5) {
                Get.to(UploadRecordsScreen());
              }
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 98,
                  decoration: BoxDecoration(
                      // color: color[index],
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(dailySisIcon[index]),
                ),
                DesignConfig.space(h: 1.h),
                CustomText(
                  text: dialysisTitle[index].toString(),
                  align: TextAlign.center,
                  color: const Color(0xFF595959),
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                )
              ],
            ),
          );
        });
  }

  Widget clientDialysisWidget() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
            mainAxisExtent: 140),
        itemCount: dailySisIcon.length,
        itemBuilder: (contex, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                // Get.to(PrescriptionDetailsScreen());
                Get.to(QrScreenScreen());
              } else if (index == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ClientDialysisAppointment()));
              } else if (index == 2) {
                Get.to(DialysisCentreScreen());
              } else if (index == 3) {
                Get.to(DialysisProductScreen());
              } else if (index == 5) {
                Get.to(UploadRecordsScreen());
              }
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 98,
                  decoration: BoxDecoration(
                      // color: color[index],
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(dailySisIcon[index]),
                ),
                DesignConfig.space(h: 1.h),
                CustomText(
                  text: clientDialysisTitle[index].toString(),
                  align: TextAlign.center,
                  color: const Color(0xFF595959),
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                )
              ],
            ),
          );
        });
  }

  Widget bestSelling() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Best Selling',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: const Color(0xFF333333),
            ),
            CustomText(
              text: 'See all',
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: const Color(0xFF677294),
            ),
          ],
        ),
        DesignConfig.space(h: 2.h),
        Container(
          height: 180,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: homeData!.bestSelling!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: 180,
                  width: 150,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.6),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DesignConfig.space(h: 1.h),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 70,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(homeData!
                                    .bestSelling![index].image
                                    .toString()),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      DesignConfig.space(h: 1.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomText(
                          text: homeData!.bestSelling![index].name.toString(),
                          color: const Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DesignConfig.space(h: 0.5.h),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  color: AppColors.yellowColor, size: 18),
                              DesignConfig.space(w: 5),
                              CustomText(
                                text: homeData!.bestSelling![index].ratings
                                    .toString(),
                                color: const Color(0xFF333333),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          )),
                      DesignConfig.space(h: 1.h),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 0.5)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: CustomText(
                                  text: 'Raise a Querry',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              homeData!.bestSelling![index].is_wishlist == 1
                                  ? Image.asset(
                                      'assets/images/heart_fill.png',
                                      height: 15,
                                    )
                                  : Image.asset(
                                      'assets/images/heart.png',
                                      height: 15,
                                    )
                            ],
                          )),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget blogs() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Blogs',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: const Color(0xFF333333),
            ),
            InkWell(
              onTap: () {
                Get.to(BlogScreen(
                  navigatePage: "home",
                ));
              },
              child: CustomText(
                text: 'See all',
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: const Color(0xFF677294),
              ),
            ),
          ],
        ),
        DesignConfig.space(h: 2.h),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: homeData!.blogs!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  height: 200,
                  width: 200,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.6),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 4,
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DesignConfig.space(h: 1.h),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 70,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    homeData!.blogs![index].image.toString()),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      DesignConfig.space(h: 1.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomText(
                          text: homeData!.blogs![index].title.toString(),
                          color: const Color(0xFF333333),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      DesignConfig.space(h: 0.5.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: CustomText(
                          text: homeData!.blogs![index].description.toString(),
                          color: const Color(0xFF677294),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      DesignConfig.space(h: 1.h),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Read more',
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                color: const Color(0xFF545454),
                              ),
                              DesignConfig.space(w: 10),
                              const Icon(
                                Icons.arrow_forward,
                                size: 16,
                              )
                            ],
                          )),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
