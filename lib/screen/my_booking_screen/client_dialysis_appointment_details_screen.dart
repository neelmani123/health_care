import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/app_colors.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:get/get.dart';
import '../../common/http_client_request.dart';
import '../../models/user_list_model/patient_details_model.dart';
import '../../models/user_list_model/use_prescription_model.dart';
import '../user_list/patient_details_image_pdf_screen.dart';
import 'client_dialysis_appointment.dart';

class ClientDialysisAppointmentDetailsScreen extends StatefulWidget {
  final id,slotTime,appointmentId;
  const ClientDialysisAppointmentDetailsScreen({super.key,this.id,this.slotTime,this.appointmentId});

  @override
  State<ClientDialysisAppointmentDetailsScreen> createState() =>
      _ClientDialysisAppointmentDetailsScreenState();
}

class _ClientDialysisAppointmentDetailsScreenState
    extends State<ClientDialysisAppointmentDetailsScreen>with TickerProviderStateMixin {
  late TabController tabController;
  PatientUserData userData=PatientUserData();
  List<UsePrescriptions> prescriptions=[];
  var prescriptionType="Prescription";
  final HttpClientServices httpClientServices=HttpClientServices();
  void patentDetailsApi()async{
    var res=await httpClientServices.patientDetailsApi(userId: widget.id);
    if(res!.result==true)
    {
      setState(() {
        userData=res.userData!;
        usePrescriptionApi(prescriptionType);
      });
    }
    else
    {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }

  void updateAppointment() async {
    var res = await httpClientServices.clientUpdateAppointmentApi(
        status: "1",
        date: "",
        appointment_id: widget.appointmentId,
        slot_time: widget.slotTime);
    if (res!.result == true) {
      setState(() {
        Fluttertoast.showToast(msg: res.message.toString());
       Get.off(ClientDialysisAppointment());
      });
    } else {
      Fluttertoast.showToast(msg: res.message.toString());
    }
  }



  void  usePrescriptionApi(var type)async{
    var res=await httpClientServices.usePrescriptionListApi(userId: widget.id,type: type);
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
    patentDetailsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:InkWell(
        onTap: (){
          updateAppointment();
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
          child: CustomText(text: 'Okay',color: AppColors.whiteColor,),
        ),
      ),
      appBar: DesignConfig.appBar(context, double.infinity, 'Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                BoxShadow(
                  color: AppColors.greyColor3,
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                )
              ]),
              child: Column(
                children: [
                  userDetails(),
                  userAddress(),
                  tabBarType(),
                  tabBarData()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget userDetails() {
    return Container(
        margin: const EdgeInsets.all(8),
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
          BoxShadow(
            color: AppColors.greyColor3,
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
          )
        ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Container(
                height: 70,
                margin: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primaryColor,width: 3),
                    image: DecorationImage(
                        image: NetworkImage(userData.image.toString()),
                        fit: BoxFit.cover)),
              ),),
              Expanded(
                flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                 Row(
                   children: [
                     CustomText(text: 'Name:',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                     SizedBox(width: 20,),
                     CustomText(text: userData.name.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
                   ],
                 ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      CustomText(text: 'Mobile :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                      SizedBox(width: 20,),
                      CustomText(text: userData.phone.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      CustomText(text: 'Address :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                      SizedBox(width: 20,),
                      CustomText(text: userData.address.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
                    ],
                  ),
                ],
              ))
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                CustomText(text: 'Allergies :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                SizedBox(width: 20,),
                CustomText(text: userData.allergies.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                CustomText(text: 'Chronic illness :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                SizedBox(width: 20,),
                CustomText(text: userData. chronicIllness.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
              ],
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget userAddress(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Divider(
            thickness: 2,
            color: Color(0xFFD0D0D0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: CustomText(text: 'Address :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)),
              SizedBox(width: 20,),
              Expanded(
                  flex: 2,
                  child: CustomText(text: userData.address.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),)),
            ],
          ),
          Divider(
            thickness: 2,
            color: Color(0xFFD0D0D0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                  child: CustomText(text: 'Last Pay :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)),
              SizedBox(width: 20,),
              Expanded(
                flex: 2,
                  child: CustomText(text: '',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),)),
            ],
          ),
          Divider(
            thickness: 2,
            color: Color(0xFFD0D0D0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                  child: CustomText(text: 'Last Come :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,)),
              SizedBox(width: 20,),
              Expanded(
                  flex: 2,
                  child: CustomText(text: '',fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),)),
            ],
          ),
          const Divider(
            thickness: 2,
            color: Color(0xFFD0D0D0),
          ),


        ],
      ),
    );
  }

  Widget tabBarType(){
    return  Container(
      padding: EdgeInsets.only(right: 2,bottom: 5),
      color:  Color(0xFFEAE4E4),
      constraints: BoxConstraints(maxHeight: 150.0),
      child: TabBar(
          onTap: (val) {
            if (val == 0) {
              setState(() {
                usePrescriptionApi("prescription");
                prescriptionType="prescription";

              });
            } else if (val == 1) {
              setState(() {
                usePrescriptionApi("Report");
                prescriptionType="report";
              });
            } else if (val == 2) {
              setState(() {
                usePrescriptionApi("medical_records");
                prescriptionType="medical_records";

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
                                child: CustomText(text: "27\nFEB",color: AppColors.whiteColor,align: TextAlign.center,),
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
