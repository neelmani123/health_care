import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_care/common/custom_text.dart';
import 'package:health_care/screen/upload_records/prescription_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/api_helper.dart';
import '../../common/app_bar.dart';
import '../../common/app_colors.dart';
import '../../common/app_images.dart';
import '../../common/pref_manager.dart';
import 'package:http/http.dart' as http;


class UploadRecordsScreen extends StatefulWidget {
  const UploadRecordsScreen({super.key});

  @override
  State<UploadRecordsScreen> createState() => _UploadRecordsScreenState();
}

class _UploadRecordsScreenState extends State<UploadRecordsScreen> {
  CarouselController buttonCarouselController = CarouselController();

  var dotIndex = 0;
  String radioValues = '';
  List<String>presceptionTYpe=['Add Prescription','Add Reports','Add Medical Records'];

  indexVal(int index, CarouselPageChangedReason a) {
    dotIndex = index;
    return dotIndex;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (builder) => bottomSheetSelector());
        },
        child: Icon(Icons.add),
      ),
      appBar: DesignConfig.appBar(
        context,
        double.infinity,
        'Upload Prescription',
      ),
      body: Column(
        children: [
          bannerCarousel(),
          DesignConfig.space(h: 5.h),
          prescriptionWidget(),
        ],
      ),
    );
  }

  Widget bannerCarousel() {
    return CarouselSlider.builder(
      itemCount: 5,
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

  Widget prescriptionWidget(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
          child: Row(
            children: [
              CustomText(text: "Add Prescription"),
              Spacer(),
              Radio(
                value:"1",
                groupValue: radioValues,
                onChanged: (val) {
                  setState(() {
                    radioValues = val!;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
          child: Row(
            children: [
              CustomText(text: "Add Reports"),
              Spacer(),
              Radio(
                value:"2",
                groupValue: radioValues,
                onChanged: (val) {
                  setState(() {
                    radioValues = val!;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
          child: Row(
            children: [
              CustomText(text: "Add Medical Records"),
              Spacer(),
              Radio(
               value: '3',
                groupValue: radioValues,
                onChanged: (val) {
                  setState(() {
                    radioValues = val!;

                  });
                },
              ),
            ],
          ),
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
  String path = "";
  XFile? _imageFiler;
  final ImagePicker _picker = ImagePicker();
  var type;
  void getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFiler = pickedFile;
      path = _imageFiler!.path;

      if(radioValues=='1')
        {
          type='Add Prescription';
        }
      else if(radioValues=='2')
        {
          type='Add Reports';
        }
      else if(radioValues=='3')

        {
          type='dd Medical Records';
        }
      updateProfile();

    });
  }

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

  updateProfile() async {
    var token = await getToken();
    print("hfjdhfkdshl"+token);
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    var baseUrl = "${apiBaseHelper.aPPmAINuRL}upload_prescription";
    var uri = Uri.parse(baseUrl);
    print("hfjdhfkdshl"+baseUrl);
    var request = http.MultipartRequest(
      "POST",
      uri,
    );
    request.headers["authorization"] = "Bearer $token";
    request.fields["type"] = type.toString();
    request.fields["title"] = '';
      request.files.add(http.MultipartFile.fromBytes(
          'file', File(path).readAsBytesSync(),
          filename: path.toString().split('/').last));
    try {
      debugPrint(jsonEncode("REquest=====>"+request.fields.toString()));
      http.Response response =
      await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.body);
        Get.to(PrescriptionDetailsScreen());
      } else {
        print("Error========+++>"+response.body.toString());
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

  Widget cameraWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Column(
        children: [
          InkWell(
            onTap: (){
              if(radioValues=="")
              {
                Fluttertoast.showToast(msg: 'Please select Prescription..');
                Get.back();
              }
              else
              {
                getImage(ImageSource.camera);
                Get.back();
              }

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
                if(radioValues=="")
                {
                  Fluttertoast.showToast(msg: 'Please select Prescription..');
                  Get.back();
                }
                else
                {
                  getImage(ImageSource.gallery);
                  Get.back();
                }
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
}
