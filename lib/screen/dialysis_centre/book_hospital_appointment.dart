import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/common/custom_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/http_request.dart';
import '../../models/dialysis_centre_model/dialysis_centre_details_model.dart';
import '../doctor_list_screen/book_dialysis_slots_screen.dart';

class BookHospitalAppointment extends StatefulWidget {
  final hospitalId, type;
  const BookHospitalAppointment({super.key, this.hospitalId, this.type});

  @override
  State<BookHospitalAppointment> createState() =>
      _BookHospitalAppointmentState();
}

class _BookHospitalAppointmentState extends State<BookHospitalAppointment> {
  final HttpServices httpServices = HttpServices();
  bool loading = true;
  DialysisCenter dialysisDetails = DialysisCenter();

  void dialysisCentreDetailsApi() async {
    final res = await httpServices.dialysisCentreDetailsApi(
        hospitalId: widget.hospitalId.toString());
    if (res!.result == true) {
      setState(() {
        dialysisDetails = res.dialysisCenter!;
        loading = false;

      });
    } else {
      Fluttertoast.showToast(msg: res.message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    dialysisCentreDetailsApi();
    super.initState();
  }
  void wishApi(String id,String type)async{
    var res=await httpServices.wishListApi(type: type,id: id);
    if(res!.result==true)
    {
      setState(() {
        Fluttertoast.showToast(msg: res.message.toString());
        dialysisCentreDetailsApi();

      });
    }
    else
    {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: CustomUi.primaryButton('Book Now', () {
          Get.to(BookDialysisslotsScreen(
            id: dialysisDetails.id.toString(),
            image: dialysisDetails.image.toString(),
            bio: dialysisDetails.description.toString(),
            name: dialysisDetails.name.toString(),
            type: widget.type,
          ));
        }, 11, AppColors.primaryColor, AppColors.whiteColor, 14, false),
      ),
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Book Hospital Appointment',
      ),
      body: SingleChildScrollView(
        child: (loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                        image: DecorationImage(
                            image: NetworkImage(
                                dialysisDetails.image.toString()))),
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
                            text: dialysisDetails.name.toString(),
                            color: const Color(0xFF3C3C3C),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          InkWell(
                              onTap: (){
                                wishApi(dialysisDetails.id.toString(),"hospital");
                              },
                              child: dialysisDetails.is_wishlist==1||dialysisDetails.is_wishlist=="1"?SvgPicture.asset('assets/svg/heart.svg'):SvgPicture.asset('assets/svg/like.svg')),
                        ],
                      ),
                      CustomText(
                        text: dialysisDetails.description.toString(),
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
                    text: dialysisDetails.totalRatings.toString(),
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

  Widget serviceTime() {
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
          Expanded(
              child: Visibility(
            visible: dialysisDetails.isOpen247 == 1||dialysisDetails.isOpen247 == "1",
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xFFCBCBCB).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.px),
                  boxShadow: []),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: '24/7',
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  CustomText(
                    text: 'Service',
                    color: Color(0xFF677294),
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          )),
          Visibility(
            visible: dialysisDetails.is_surgery == 1||dialysisDetails.is_surgery == "1",
            child: Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xFFCBCBCB).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.px),
                  boxShadow: []),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Cancer',
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  CustomText(
                    text: 'Surgery',
                    color: Color(0xFF677294),
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ],
              ),
            )),
          ),
          Visibility(
            visible: dialysisDetails.isEmergency == 1|| dialysisDetails.isEmergency == "1",
            child: Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFFCBCBCB).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10.px),
                  boxShadow: []),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: '24 hour',
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  CustomText(
                    text: 'Emergency',
                    color: Color(0xFF677294),
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget servicesWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomUi.htmlText(dialysisDetails.services.toString()),
    );
  }

  Widget locationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Location',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
          DesignConfig.space(h: 2.h),
          SizedBox(
            height: 300,
            child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
          )),
        ],
      ),
    );
  }

  late GoogleMapController mapController;
  static const LatLng _center = const LatLng(28.730930871376117, 77.14460473535264);
  void _onMapCreated(GoogleMapController controller) {
    mapController=controller;
  }


}
