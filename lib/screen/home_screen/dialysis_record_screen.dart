import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/http_request.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../models/home_model/dialysis_record_model.dart';
import '../user_list/patient_details_image_pdf_screen.dart';

class DialysisRecordScreen extends StatefulWidget {
  const DialysisRecordScreen({super.key});

  @override
  State<DialysisRecordScreen> createState() => _DialysisRecordScreenState();
}

class _DialysisRecordScreenState extends State<DialysisRecordScreen>with TickerProviderStateMixin {

  late TabController tabController;
  final HttpServices httpServices=HttpServices();
  List<DailysisRecordPrescriptions> prescriptions=[];


  void  usePrescriptionApi(var type)async{
    var res=await httpServices.dialysisRecordApi(type: type);
    if(res!.result==true)
    {
      setState(() {
        prescriptions=res.prescriptions!;
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
    tabController = TabController(length: 3, vsync: this);
    usePrescriptionApi('prescription');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DesignConfig.appBar(context, double.infinity, 'Dialysis Record'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchWidget(),
            DesignConfig.space(h: 20),
            tabBarType(),
            DesignConfig.space(h: 10),
            tabBarData()
          ],
        ),
      ),
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
              hintText: 'Search',
              hintStyle: TextStyle(
                  color: Color(0xFF818286),
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
        ));
  }

  Widget tabBarType(){
    return  Container(

      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(right: 2,bottom: 5),
      color:  Color(0xFFEAE4E4),
      constraints: BoxConstraints(maxHeight: 150.0),
      child: TabBar(
          onTap: (val) {
            if (val == 0) {
              setState(() {
                usePrescriptionApi("prescription");


              });
            } else if (val == 1) {
              setState(() {
                usePrescriptionApi("reports");
              });
            } else if (val == 2) {
              setState(() {
                usePrescriptionApi("dialysis_records");


              });
            }
          },
          isScrollable: true,
          controller: tabController,
          tabs: const [
            Tab(
              text: 'Prescription',
            ),
            Tab(
              text: 'Report',
            ),
            Tab(
              text: 'Medical Records',
            ),
          ]),
    );
  }

  Widget tabBarData(){
    return Container(
      child:prescriptions.isEmpty?Center(child: CustomText(text: 'No data found...'),):ListView.builder(
          itemCount: prescriptions.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>PatientDetailsImagePdfScreen(type: prescriptions[index].fileType,file: prescriptions[index].file,)));
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.17),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 2)
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
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 70,
                                margin: EdgeInsets.only(bottom: 7),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomText(text: prescriptions[index].date.toString(),color: AppColors.whiteColor,align: TextAlign.center,),
                              ),
                              Container(
                                height: 30 ,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color:Color(0xFF0EBE7F1A)
                                ),
                                // padding: EdgeInsets.only(left: 3,right: 3,top: 5),
                                child: CustomText(text: 'NEW',fontWeight: FontWeight.w500,fontSize: 12,color: AppColors.primaryColor,),
                              )
                            ],
                          ),),
                        DesignConfig.space(w: 10),
                        Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: prescriptions[index].title.toString(),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor,
                                ),
                                DesignConfig.space(h: 10),
                                CustomText(
                                  text: prescriptions[index].text.toString(),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                                DesignConfig.space(h: 10),

                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }) ,
    );
  }
}
