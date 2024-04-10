import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/http_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/custom_text.dart';
import '../../models/dialysis_product_model/prescription_model.dart';

class PrescriptionDetailsScreen extends StatefulWidget {
  const PrescriptionDetailsScreen({super.key});

  @override
  State<PrescriptionDetailsScreen> createState() =>
      _PrescriptionDetailsScreenState();
}

class _PrescriptionDetailsScreenState extends State<PrescriptionDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
final HttpServices  httpServices=HttpServices();
  List<Prescriptions> prescriptions=[];

  void prescriptionApi()async{
    var res=await httpServices.prescriptionApi();
    if(res!.result==true)
      {
        setState(() {
          prescriptions=res.prescriptions!;
        });
      }
    else{
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this);
    prescriptionApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: DesignConfig.appBar(
              context, double.infinity, 'My Doctors prescriptions'),
          body: Column(
            children: [
              DesignConfig.space(h: 2.h),
              searchWidget(),
              DesignConfig.space(h: 2.h),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEAE4E4)
                ),
                child: TabBar(
                  isScrollable: true,
                    tabs: [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Prescription',
                  ),
                  Tab(
                    text: 'Reports',
                  ),
                  Tab(
                    text: 'Dialysis records',
                  ),
                ]),
              ),
              Expanded(child: prescriptionTabItems())
            ],
          ),
        ));
  }


  Widget searchWidget() {
    return Container(
        height: 7.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
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
              hintText: 'Search ',
              hintStyle: TextStyle(
                  color: Color(0xFF818286),
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
        ));
  }


  Widget prescriptionTabItems() {
    return ListView.builder(
      itemCount: prescriptions.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
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
                      flex: 1,
                      child: Container(
                        height: 80,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primaryColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(text: '27',fontSize: 13,fontWeight: FontWeight.w500,color: AppColors.whiteColor,),
                            CustomText(text: 'FEB',fontSize: 13,fontWeight: FontWeight.w500,color: AppColors.whiteColor,),
                          ],
                        ),
                      )),
                  DesignConfig.space(w: 5.w),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: prescriptions[index].title.toString(),
                                color: const Color(0xFF3C3C3C),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              const Icon(Icons.more_vert),
                            ],
                          ),
                          CustomText(
                            text:
                            prescriptions[index].type.toString(),
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      )),
                ],
              ),
              DesignConfig.space(h: 1.h),
              Container(
               width: 60,
               alignment: Alignment.center,
               margin: EdgeInsets.only(left: 10),
               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF0EBE7F1A).withOpacity(0.10)),
                child: CustomText(text: 'NEW',fontWeight: FontWeight.w500,fontSize: 12,color: AppColors.primaryColor,),
              )
            ],
          ),
        );
        });
  }

}
