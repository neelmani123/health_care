import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_care/common/app_bar.dart';
import 'package:health_care/common/http_client_request.dart';
import 'package:health_care/screen/user_list/patient_details_image_pdf_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../common/api_helper_client.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text.dart';
import '../../common/pref_manager.dart';
import 'dart:io';
import '../../models/user_list_model/patient_details_model.dart';
import '../../models/user_list_model/use_prescription_model.dart';

class PatentDetailsScreen extends StatefulWidget {
  final userId;
  const PatentDetailsScreen({super.key,this.userId});

  @override
  State<PatentDetailsScreen> createState() => _PatentDetailsScreenState();
}

class _PatentDetailsScreenState extends State<PatentDetailsScreen>with TickerProviderStateMixin {

  final HttpClientServices httpClientServices=HttpClientServices();
  PatientUserData userData=PatientUserData();
  late TabController tabController;
  List<UsePrescriptions> prescriptions=[];
  var prescriptionType="Prescription";
  void patentDetailsApi()async{
    var res=await httpClientServices.patientDetailsApi(userId: widget.userId);
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



  void  usePrescriptionApi(var type)async{
    var res=await httpClientServices.usePrescriptionListApi(userId: widget.userId,type: type);
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

  String path = "";
  XFile? _imageFiler;
  final ImagePicker _picker = ImagePicker();


  Future<String> getToken() async {
    var token = "";
    await PrefManager.getUserData().then((value) => {
      debugPrint("Token------------>${value.token}", wrapWidth: 5000),
      setState(() {
        token = value.token;
      }),
    });
    return token;
  }
  updatePrescription() async {
    var token = await getToken();
    ApiBaseClient apiBaseHelper = ApiBaseClient();
    var baseUrl = "${apiBaseHelper.appDoctorMainUrl}upload_prescription";
    var uri = Uri.parse(baseUrl);
    var request = http.MultipartRequest(
      "POST",
      uri,
    );

    request.headers["authorization"] = "Bearer $token";
    request.fields["type"] = prescriptionType.toString();
    request.fields["user_id"] = widget.userId.toString();
    request.files.add(http.MultipartFile.fromBytes(
        'file', await File(path).readAsBytesSync(),
        filename: path.toString().split('/').last))
    ;
    try {
      debugPrint("kjhkgkgkgh===>"+jsonEncode(request.toString()));
      http.Response response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print("hfjdsgfmdfjgdfgdjkg=====>${response.body.toString()}");
        Navigator.pop(context);
        usePrescriptionApi(prescriptionType.toString());

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${jsonDecode(response.body)['message']}")));
      } else {
        print("hfjdsgfmdfjgdfgdjkg=====>${response.body.toString()}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.statusCode}"),
          ),
        );

      }
    } catch (exception) {
      debugPrint("exception:==>$exception");
    }

  }

  void getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFiler = pickedFile;
      path = _imageFiler!.path;
      print("Image path is=======>"+path.toString());
      updatePrescription();
    });
  }

  Widget cameraWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            InkWell(
              onTap: (){
                getImage(ImageSource.camera);
              },
              child: Container(
                alignment: Alignment.center,
                height: 10.h,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyColor3,width: 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.greyColor1.withOpacity(0.5),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 0.1
                      )
                    ]
                ),
                child: Image.asset('assets/images/camera.png',height: 60,),
              ),
            ),
            DesignConfig.space(h: 1.h),
            CustomText(text: 'Take photo',fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,)
          ],
        ),
        DesignConfig.space(w: 7.h),
        Column(
          children: [
            InkWell(
              onTap: (){
                getImage(ImageSource.gallery);
              },
              child: Container(
                alignment: Alignment.center,
                height: 10.h,
                width: 90,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyColor3,width: 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.greyColor1.withOpacity(0.5),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 0.1
                      )
                    ]
                ),
                child:  Image.asset('assets/images/prescription.png',height: 60,),
              ),
            ),
            DesignConfig.space(h: 1.h),
            CustomText(text: 'Select Prescription',fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.blackColor,)
          ],
        ),
      ],
    );
  }
  Widget bottomSheetSelector() {
    return Container(
      height: 200.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.greyColor3.withOpacity(0.2)
            ),
            child: CustomText(text:'Upload Prescription',color: Color(0xFF151921),fontWeight: FontWeight.w600,fontSize: 15,),
          ),
          const SizedBox(
            height: 40,
          ),
          cameraWidget(),

        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (builder) => bottomSheetSelector());
        },
        child: Icon(Icons.add,color: AppColors.whiteColor,),
      ),
      appBar: DesignConfig.appBar(context, double.infinity, 'Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DesignConfig.space(h: 10),
            searchWidget(),
            userDetails(),
            tabBarType(),
            DesignConfig.space(h: 10),
            tabBarData(),

          ],
        ),
      ),
    );
  }


  Widget searchWidget() {
    return Container(
        height: 5.h,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color(0xFFF3F2E9),
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(
                Icons.filter_alt_outlined,
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

  Widget userDetails() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow:  [
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
              Expanded(
                child: Container(
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
                          CustomText(text:  userData.phone.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          CustomText(text: 'Address :',fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.blackColor,),
                          SizedBox(width: 20,),
                          CustomText(text:  userData.address.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
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
                CustomText(text:  userData.allergies.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
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
                CustomText(text:  userData.chronicIllness.toString(),fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF5F5D5D),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget tabBarType(){
    return  Container(
      padding: EdgeInsets.only(right: 10,bottom: 5),
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
